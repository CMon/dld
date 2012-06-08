include(config.pri)

TEMPLATE = subdirs

CONFIG(gainData) {
	message("Building gainData")
	SUBDIRS += \
		src/gainData
}  

CONFIG(generatePosition) {
	message("Building generatePosition")
	SUBDIRS += \
		src/generatePosition
}  

CONFIG(mapGen) {
	message("Building mapGen")
	SUBDIRS += \
		src/mapGen
}  

CONFIG(obConfig) {
	message("Building obConfig")
	SUBDIRS += \
		src/obConfig
}  

CONFIG(pdAdmin) {
	message("Building pdAdmin")
	SUBDIRS += \
		src/pdAdmin
}  

CONFIG(showPos) {
	message("Building showPos")
	SUBDIRS += \
		src/showPos
}  

