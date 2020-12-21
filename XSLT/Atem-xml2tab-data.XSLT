<?xml version="1.0" encoding="utf-8"?>
<!--
    #############################################################
    # Name:     	.xslt
    # Purpose:  	.
    # Part of:  	Xrunner - https://github.com/SILAsiaPub/xrunner
    # Author:   	Ian McQuay <ian_mcquay@sil.org>
    # Created:  	2020- -
    # Copyright:	(c) 2020 SIL International
    # Licence:  	<MIT>
    ################################################################ -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:f="myfunctions" exclude-result-prefixes="f">
<xsl:strip-space elements="*"/>
    <xsl:output method="text" encoding="utf-8"/>
    <xsl:include href="project.xslt"/>
    <xsl:template match="/*">
        <xsl:text>index	Name	Position	Type	Input	Size%	Switch</xsl:text>
        <xsl:apply-templates select="//Macro"/>
    </xsl:template>
    <xsl:template match="Macro">
        <xsl:variable name="cell" select="tokenize(.,'\t')"/>
        <xsl:variable name="x-pos">
            <xsl:choose>
                <xsl:when test="number(*[@id = 'DVEAndFlyKeyXPosition']/@xPosition) lt 0">
                    <xsl:text>l</xsl:text>
                </xsl:when>
                <xsl:when test="number(*[@id = 'DVEAndFlyKeyXPosition']/@xPosition) = 0">
                    <xsl:text>c</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>r</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="y-pos">
            <xsl:choose>
                <xsl:when test="number(*[@id = 'DVEAndFlyKeyYPosition']/@yPosition) lt 0">
                    <xsl:text>b</xsl:text>
                </xsl:when>
                <xsl:when test="number(*[@id = 'DVEAndFlyKeyYPosition']/@yPosition) = 0">
                    <xsl:text>m</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>t</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="pos" select="concat($y-pos,$x-pos)"/>
        
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="@index"/>
        <xsl:text>&#9;</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>&#9;</xsl:text>
        <xsl:value-of select="$pos"/>
        <xsl:text>&#9;</xsl:text>
        <xsl:value-of select="*[@id = 'KeyType']/@type"/>
        <xsl:text>&#9;</xsl:text>
        <xsl:value-of select="substring-after(*[@id = 'KeyFillInput']/@input,'Camera')"/>
        <xsl:text>&#9;</xsl:text>
        <xsl:value-of select="number(*[@id = 'DVEAndFlyKeyXSize'][1]/@xSize) * 100"/>
        <xsl:text>&#9;</xsl:text>
        <xsl:value-of select="*[@id = 'KeyOnAir'][last()]/@onAir"/>
        <xsl:text>&#9;</xsl:text>
        <xsl:value-of select="*[@id = 'KeyFillInput'][last()]/@input"/>
    </xsl:template>
</xsl:stylesheet>
