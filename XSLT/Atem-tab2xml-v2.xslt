<?xml version="1.0" encoding="utf-8"?>
<!--
    #############################################################
    # Name:     	.xslt
    # Purpose:  	Take minimal table info and make a ATEM mini .
    # Part of:  	Xrunner - https://github.com/SILAsiaPub/xrunner
    # Author:   	Ian McQuay <ian_mcquay@sil.org>
    # Created:  	2020- -
    # Copyright:	(c) 2020 SIL International
    # Licence:  	<MIT>
    ################################################################ -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:f="myfunctions" exclude-result-prefixes="f">
    <xsl:output method="xml" version="1.0" encoding="utf-8" omit-xml-declaration="no" indent="yes"/>
    <xsl:include href="project.xslt"/>
    <xsl:variable name="head" select="tokenize($macro-data[1],'\t')"/>
    <xsl:variable name="macro">
        <xsl:for-each select="$macro-data[position() gt 1]">
            <xsl:variable name="cell" select="tokenize(.,'\t')"/>
            <xsl:element name="row">
                <xsl:for-each select="$cell">
                    <xsl:variable name="pos" select="position()"/>
                    <xsl:element name="{lower-case(translate($head[number($pos)],'%',''))}">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:for-each>
    </xsl:variable>
    <xsl:template match="/">
        <Profile majorVersion="1" minorVersion="5" product="ATEM Mini">
            <MacroPool>
                <xsl:apply-templates select="$macro/row"/>
            </MacroPool>
            <MacroControl loop="False"/>
        </Profile>
    </xsl:template>
    <xsl:template match="row">
<xsl:if test="string-length(name) != 0">


        <xsl:element name="Macro">
            <xsl:attribute name="index">
                <xsl:value-of select="index"/>
            </xsl:attribute>
            <xsl:attribute name="name">
                <xsl:value-of select="name"/>
            </xsl:attribute>
            <xsl:attribute name="description">
                            <!-- nothing for now -->
                        </xsl:attribute>
            <xsl:if test="switch = 'True'">
                <Op id="KeyType" mixEffectBlockIndex="0" keyIndex="0" type="{type}"/>
                <Op id="KeyFillInput" mixEffectBlockIndex="0" keyIndex="0" input="{input}"/>
                <xsl:if test="type = 'Luma'">
                    <Op id="KeyCutInput" mixEffectBlockIndex="0" keyIndex="0" input="{keycut}"/>
                    <Op id="LumaKeyPreMultiply" mixEffectBlockIndex="0" keyIndex="0" preMultiply="True"/>
                </xsl:if>
                <Op id="DVEKeyMaskEnable" mixEffectBlockIndex="0" keyIndex="0" enable="False"/>
                <xsl:if test="type = 'DVE'">
                    <Op id="DVEKeyMaskEnable" mixEffectBlockIndex="0" keyIndex="0" enable="False"/>
                    <Op id="DVEKeyBorderEnable" mixEffectBlockIndex="0" keyIndex="0" enable="False"/>
                </xsl:if>
                <Op id="DVEAndFlyKeyXPosition" mixEffectBlockIndex="0" keyIndex="0" xPosition="{f:xpos(size,position)}"/>
                <Op id="DVEAndFlyKeyYPosition" mixEffectBlockIndex="0" keyIndex="0" yPosition="{f:ypos(size,position)}"/>
                <Op id="DVEAndFlyKeyXSize" mixEffectBlockIndex="0" keyIndex="0" xSize="{format-number(number(size) * 0.01, '0.00')}"/>
                <Op id="DVEAndFlyKeyYSize" mixEffectBlockIndex="0" keyIndex="0" ySize="{format-number(number(size) * 0.01, '0.00')}"/>
                <Op id="MacroSleep" frames="1"/>
            </xsl:if>
            <Op id="KeyOnAir" mixEffectBlockIndex="0" keyIndex="0" onAir="{switch}"/>
        </xsl:element>
</xsl:if>
    </xsl:template>
    <!-- <xsl:function name="f:value">
        <xsl:param name="cell"/>
        <xsl:param name="match"/>
        <xsl:value-of select="$cell[number(f:position($head,$match))]"/>
    </xsl:function> -->
    <xsl:function name="f:xpos">
        <xsl:param name="size"/>
        <xsl:param name="pos"/>
        <xsl:variable name="xsize" select="number($xscr) * number($size) * 0.01"/>
        <xsl:variable name="xhalfsize" select="number($xsize) * .5"/>
        <xsl:choose>
            <xsl:when test="substring($pos,2,1) = 'r'">
                <xsl:value-of select="format-number((number($xhalfscr) - number($xhalfsize)) * 0.0166667, '#.##')"/>
            </xsl:when>
            <xsl:when test="substring($pos,2,1) = 'l'">
                <xsl:value-of select="format-number((number($xhalfsize) - number($xhalfscr))  * 0.0166667, '#.##')"/>
            </xsl:when>
            <xsl:when test="substring($pos,2,1) = 'c'">
                <xsl:value-of select="0"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>
    <xsl:function name="f:ypos">
        <xsl:param name="size"/>
        <xsl:param name="pos"/>
        <xsl:variable name="ysize" select="number($yscr) * number($size) * 0.01"/>
        <xsl:variable name="yhalfsize" select="number($ysize) * 0.5"/>
        <xsl:choose>
            <xsl:when test="substring($pos,1,1) = 't'">
                <xsl:value-of select="format-number((number($yhalfscr) - number($yhalfsize))  * 0.0166667, '0.##')"/>
            </xsl:when>
            <xsl:when test="substring($pos,1,1) = 'b'">
                <xsl:value-of select="format-number((number($yhalfsize) - number($yhalfscr))  * 0.0166667, '0.##')"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>
