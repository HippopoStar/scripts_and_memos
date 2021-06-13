#!/bin/sh

# For compatibiblity reasons, this script is intented to be run on a RaspberryPi device

# Concerning MongoDB
# https://hub.docker.com/_/mongo
# https://hub.docker.com/layers/mongo/library/mongo/bionic/images/sha256-c740f5fce802628d8837ad78d443dda66eecc3db7e8143943c5494a86fe57d7c?context=explore
# https://github.com/docker-library/mongo/blob/master/4.4/Dockerfile

COLOR_BRIGHT="$(echo "\033[01m")"
EOC="$(echo "\033[00m")"

RASPBIAN_IMAGE_ARCHIVE_NAME='2021-05-07-raspios-buster-armhf-lite'
RASPBIAN_IMAGE_ARCHIVE_DOWNLOAD_ADDRESS="https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-05-28/${RASPBIAN_IMAGE_ARCHIVE_NAME}.zip"
TEMPORARY_DIRECTORY='/tmp/raspbian_docker_tmp'
HOME_DOWNLOADS_DIRECTORY_NAME='Downloads'
RASPBIAN_IMAGE_MOUNT_POINT='/mnt/img'

TIMEZONE="$(cat /etc/timezone)"
#TIMEZONE='Europe/Paris'
DOCKER_IMPORT_COMMIT_MSG="Image generated using \"$(echo "${0}" | xargs basename)\" on $(TZ="${TIMEZONE}" date +'%F at %T GMT%:z')"
#echo "${DOCKER_IMPORT_COMMIT_MSG}"

main () {
	local RASPBIAN_DISK_IMAGE_PARTITION_TABLE=''
	local RASPBIAN_DISK_IMAGE_LINUX_PARTITION_SECTORS_OFFSET=''
	local RASPBIAN_DISK_IMAGE_LINUX_PARTITION_BYTES_OFFSET=''

	# Voir https://www.raspberrypi.org/software/operating-systems/#raspberry-pi-os-32-bit
	# Section 'Raspberry Pi OS Lite'
	if [ ! \( -e ~/"${HOME_DOWNLOADS_DIRECTORY}" -a -d ~/"${HOME_DOWNLOADS_DIRECTORY}" \) ]
	then
		echo "Error: directory \"~/${HOME_DOWNLOADS_DIRECTORY}\" seems not to exist"
		exit 0
	fi
	if [ -e "${TEMPORARY_DIRECTORY}" -a -d "${TEMPORARY_DIRECTORY}" ]
	then
		rm --recursive --interactive=never --verbose "${TEMPORARY_DIRECTORY}"
	fi
	mkdir --parents --verbose "${TEMPORARY_DIRECTORY}"
	if [ ! \( -e ~/"${HOME_DOWNLOADS_DIRECTORY_NAME}/${RASPBIAN_IMAGE_ARCHIVE_NAME}.zip" -a -f ~/"${HOME_DOWNLOADS_DIRECTORY_NAME}/${RASPBIAN_IMAGE_ARCHIVE_NAME}.zip" \) ]
	then
		curl -o ~/"${HOME_DOWNLOADS_DIRECTORY_NAME}/${RASPBIAN_IMAGE_ARCHIVE_NAME}.zip" "${RASPBIAN_IMAGE_ARCHIVE_DOWNLOAD_ADDRESS}"
	fi
	unzip ~/"${HOME_DOWNLOADS_DIRECTORY_NAME}/${RASPBIAN_IMAGE_ARCHIVE_NAME}.zip" -d "${TEMPORARY_DIRECTORY}"
	ls --size --human-readable --format=single-column "${TEMPORARY_DIRECTORY}/${RASPBIAN_IMAGE_ARCHIVE_NAME}.img"
	# Voir /proc/filesystems et /proc/mounts
	RASPBIAN_DISK_IMAGE_PARTITION_TABLE="$(fdisk -l "${TEMPORARY_DIRECTORY}/${RASPBIAN_IMAGE_ARCHIVE_NAME}.img")"
	echo "${COLOR_BRIGHT}RASPBIAN_DISK_IMAGE_PARTITION_TABLE${EOC}:"
	echo "${RASPBIAN_DISK_IMAGE_PARTITION_TABLE}"
	RASPBIAN_DISK_IMAGE_LINUX_PARTITION_SECTORS_OFFSET="$(echo "${RASPBIAN_DISK_IMAGE_PARTITION_TABLE}" | grep -e 'Linux$' | awk '{ print $2 }')"
	echo "${COLOR_BRIGHT}RASPBIAN_DISK_IMAGE_LINUX_PARTITION_SECTORS_OFFSET${EOC}:"
	echo "${RASPBIAN_DISK_IMAGE_LINUX_PARTITION_SECTORS_OFFSET}"
	RASPBIAN_DISK_IMAGE_LINUX_PARTITION_BYTES_OFFSET="$((RASPBIAN_DISK_IMAGE_LINUX_PARTITION_SECTORS_OFFSET * 512))"
	echo "${COLOR_BRIGHT}RASPBIAN_DISK_IMAGE_LINUX_PARTITION_BYTES_OFFSET${EOC}:"
	echo "${RASPBIAN_DISK_IMAGE_LINUX_PARTITION_BYTES_OFFSET}"
	sudo mkdir --parents --verbose "${RASPBIAN_IMAGE_MOUNT_POINT}"
	sudo mount -o loop,offset="${RASPBIAN_DISK_IMAGE_LINUX_PARTITION_BYTES_OFFSET}" "${TEMPORARY_DIRECTORY}/${RASPBIAN_IMAGE_ARCHIVE_NAME}.img" "${RASPBIAN_IMAGE_MOUNT_POINT}"
	cat <<-EOF | sudo chroot "${RASPBIAN_IMAGE_MOUNT_POINT}"
		#apt-get update && apt-get upgrade -y
		#rm /etc/apt/sources.list
	EOF
	# If run without using 'sudo', following 'tar' command fails to gather directories on which only 'root' user has read permission
	# (try using 'tar cvf' and pay close attention to logs to figure it out)
	echo "Running ${COLOR_BRIGHT}tar${EOC} command..."
	sudo tar cf "${TEMPORARY_DIRECTORY}/docker_image_raspbian.tar" -C "${RASPBIAN_IMAGE_MOUNT_POINT}" ./
	echo "Running ${COLOR_BRIGHT}docker import${EOC} command..."
	echo "${DOCKER_IMPORT_COMMIT_MSG}"
	docker import -m "${DOCKER_IMPORT_COMMIT_MSG}" "${TEMPORARY_DIRECTORY}/docker_image_raspbian.tar" raspbian:latest
	sudo umount -v "${RASPBIAN_IMAGE_MOUNT_POINT}"
	sudo rm --dir --interactive=once --verbose "${RASPBIAN_IMAGE_MOUNT_POINT}"
	echo "${COLOR_BRIGHT}docker image ls${EOC}"
	docker image ls
	echo "${COLOR_BRIGHT}docker image history raspbian:latest${EOC}"
	docker image history raspbian:latest
}

main

