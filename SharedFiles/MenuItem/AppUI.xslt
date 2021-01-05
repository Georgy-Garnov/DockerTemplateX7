<?xml version="1.0"?>
<!--
Permission is hereby granted, free of charge, to any person or organization obtaining a copy of the software and accompanying 
documentation covered by this license (the "Software") to use, reproduce, display, distribute, execute, and transmit the Software, 
and to prepare derivative works of the Software, and to permit third-parties to whom the Software is furnished to do so, all subject 
to the following:

The copyright notices in the Software and this entire statement, including the above license grant, the original location it was 
downloaded from, this restriction and the following disclaimer, must be included in all copies of the Software, in whole or in part, 
and all derivative works of the Software, unless such copies or derivative works are solely in the form of machine-executable object
code generated by a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. THE SOFTWARE MAY CONTAIN BUGS, ERRORS AND OTHER
PROBLEMS THAT COULD CAUSE SYSTEM FAILURES AND THE USE OF SUCH SOFTWARE IS ENTIRELY AT THE USER'S RISK. IN NO EVENT SHALL THE COPYRIGHT
HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE, 
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

************************************************************************************************************************************
This file defines new UI elements that all workspaces will contain
************************************************************************************************************************************
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:frmwrk="Corel Framework Data">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <!-- Use these elements for the framework to move the container from the app config file to the user config file -->
  <!-- Since these elements use the frmwrk name space, they will not be executed when the XSLT is applied to the user config file -->
  <frmwrk:uiconfig>
    <!-- The Application Info should always be the topmost frmwrk element -->
    <frmwrk:applicationInfo userConfiguration="true" />
  </frmwrk:uiconfig>

  <!-- Copy everything -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="uiConfig/items">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
		<!-- Creates a button to add at a menu, menu item needs works with DataSource-->
		<itemData guid="$GuidA$" noBmpOnMenu="true"
				   type="button"
				   onInvoke='*Bind(DataSource=$safeprojectname$DS;Path=MenuItemCommand)'
				   caption='*Bind(DataSource=$safeprojectname$DS;Path=Caption)'
				   enable="true"/>
			<!--<userSmallBitmap xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="bin.base64">
				*Bind(DataSource=$safeprojectname$DS;Path=Icon)
			</userSmallBitmap>
		</itemData>-->
		<!--Creates a item to add a Warpper, responsible to initialize the DataSource to be consumimed in menu item above -->
      <itemData guid="$GuidB$"
                type="wpfhost"
                hostedType="Addons\$specifiedsolutionname$\$specifiedsolutionname$.dll,$safeprojectname$.ControlUI"
                enable="true"/>

    </xsl:copy>
  </xsl:template>

  <xsl:template match="uiConfig/commandBars">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>

   
        <container>
          <!-- add the Warpper control to the container -->
          <item dock="fill" margin="0,0,0,0" guidRef="$GuidB$"/>
        </container>
     
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
