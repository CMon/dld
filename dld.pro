include(config.pri)

TEMPLATE = subdirs

SUBDIRS += src/common

CONFIG(gainData) {
	message("Building gainData")
	SUBDIRS += \
		src/gainData
	gainData.depends = src/common
}  

CONFIG(generatePosition) {
	message("Building generatePosition")
	SUBDIRS += \
		src/generatePosition
	generatePosition.depends = src/common
}  

CONFIG(mapGen) {
	message("Building mapGen")
	SUBDIRS += \
		src/mapGen
	mapGen.depends = src/common
}  

CONFIG(obConfig) {
	message("Building obConfig")
	SUBDIRS += \
		src/obConfig
	obConfig.depends = src/common
}

CONFIG(pdAdmin) {
	message("Building pdAdmin")
	SUBDIRS += \
		src/pdAdmin
	pdAdmin.depends = src/common
}

CONFIG(showPos) {
	message("Building showPos")
	SUBDIRS += \
		src/showPos
	showPos.depends = src/common
}

