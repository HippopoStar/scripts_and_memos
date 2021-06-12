#!/bin/bash

# Voir https://www.eclipse.org/downloads/ pour les differentes version de l'installateur
ECLIPSE_IDE_INSTALLER_ARCHIVE_NAME='eclipse-inst-jre-linux64'
ECLIPSE_IDE_RELEASE_DATE='2021-03'
ECLIPSE_IDE_INSTALLER_DOWNLOAD_ADDRESS="https://www.eclipse.org/downloads/download.php?file=/oomph/epp/${ECLIPSE_IDE_RELEASE_DATE}/R/${ECLIPSE_IDE_INSTALLER_ARCHIVE_NAME}.tar.gz"

TEMPORARY_DIRECTORY='/tmp/eclipse_tmp'

install_eclipse_ide () {
	curl -o "${TEMPORARY_DIRECTORY}/${ECLIPSE_IDE_INSTALLER_ARCHIVE_NAME}.tar.gz" "${ECLIPSE_IDE_INSTALLER_DOWNLOAD_ADDRESS}"
	tar xvzf "${TEMPORARY_DIRECTORY}/${ECLIPSE_IDE_INSTALLER_ARCHIVE_NAME}"
	"${TEMPORARY_DIRECTORY}/${ECLIPSE_IDE_INSTALLER_ARCHIVE_NAME}/eclipse-inst"
}

add_eclipe_ide_to_application_launcher () {
	local ECLIPSE_VECTORIAL_IMAGE_ARCHIVE_NAME='eclipse_Logov2'
	local SIZE=''

	sudo ln -s ~/"eclipse/cpp-${ECLIPSE_IDE_RELEASE_DATE}/eclipse/eclipse" '/usr/bin/eclipse'
	cat <<EOF > "${TEMPORARY_DIRECTORY}/eclipse.desktop"
[Desktop Entry]
Name=Eclipse IDE
Comment=Eclipse IDE by Eclipse Foundation
Exec=eclipse
Icon=eclipse
Terminal=false
Type=Application
Categories=Utility;
Keywords=Eclipse;IDE;
StartupNotify=true
EOF
	sudo mv "${TEMPORARY_DIRECTORY}/eclipse.desktop" '/usr/share/applications/'
	curl -o "${TEMPORARY_DIRECTORY}/${ECLIPSE_VECTORIAL_IMAGE_ARCHIVE_NAME}.zip" "https://www.eclipse.org/org/artwork/zip_files/${ECLIPSE_VECTORIAL_IMAGE_ARCHIVE_NAME}.zip"
	unzip "${TEMPORARY_DIRECTORY}/${ECLIPSE_VECTORIAL_IMAGE_ARCHIVE_NAME}.zip"
	sudo cp "${TEMPORARY_DIRECTORY}/${ECLIPSE_VECTORIAL_IMAGE_ARCHIVE_NAME}/Eclipse2014_RGB.svg" '/usr/share/icons/hicolor/scalable/apps/eclipse.svg'
	sudo cp "${TEMPORARY_DIRECTORY}/${ECLIPSE_VECTORIAL_IMAGE_ARCHIVE_NAME}/Eclipse2014_RGB.svg" '/usr/share/icons/hicolor/symbolic/apps/eclipse-symbolic.svg'
	sudo apt-get update && sudo apt-get install imagemagick
	for SIZE in 16 22 24 32 48
	do
		sudo convert -resize "${SIZE}x${SIZE}" ~/"eclipse/cpp-${ECLIPSE_IDE_RELEASE_DATE}/eclipse/icon.xpm" "/usr/share/icons/hicolor/${SIZE}x${SIZE}/apps/eclipse.png"
	done
	sudo convert ~/"eclipse/cpp-${ECLIPSE_IDE_RELEASE_DATE}/eclipse/icon.xpm" '/usr/share/icons/hicolor/256x256/apps/eclipse.png'
}

main () {
	if [ "x$(apt-cache show openjdk-11-jdk 2>/dev/null)" = 'x' ]
	then
		echo 'Sorry, OpenJDK version 11 seems not to be available on your system'
	else
		sudo apt-get update && sudo apt-get install openjdk-11-jdk
		if [ -e "${TEMPORARY_DIRECTORY}" -a -d "${TEMPORARY_DIRECTORY}" ]
		then
			rm --recursive --force "${TEMPORARY_DIRECTORY}"
		fi
		mkdir --parents "${TEMPORARY_DIRECTORY}"
		install_eclipse_ide
		add_eclipe_ide_to_application_launcher
	fi
}

main

