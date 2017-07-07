<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns:oscal="http://scap.nist.gov/schema/oscal">
  
  <xsl:template match="/">
    <html>
      <head>
        <xsl:apply-templates select="descendant::oscal:title[1]" mode="title"/>
        <style type="text/css">

.control { margin:1em; padding: 1em; border: thin dotted black }
.control > *:first-child { margin-top: 0em }

h1, h2, h3, h4, h5, h6 { font-family: sans-serif }
h3 { font-size: 120% }

div, section { border-left: thin solid black; padding-left: 0.5em; margin-left: 0.5em }

section h3     { font-size: 160% }
section h3     { font-size: 140% }
div h3         { font-size: 130% }
div div h3     { font-size: 120% }
div div div h3 { font-size: 110% }

.param { font-style: italic }
.assign, .choice { border: thin solid black; padding: 0.1em }

.source { font-family: monospace; font-weight: bold; color: darkgreen; font-size: 120% }
.target { font-family: monospace; font-weight: bold; color: darkred; font-size: 120%   }
.concept, .remarks { font-size: 80% }

.subst  { color: midnightblue; font-family: sans-serif; font-sizea; 85% } 

th, td { border: thin dotted black; vertical-align: top }
td > *:first-child { margin-top: 0em }

.empty { background-color: darkgrey }

.param .em { font-style: roman }

        </style>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:variable name="table-layout">
    <tr>
      <th>source</th>
      <th>target</th>
      <th>concept</th>
      <th>remarks</th>
    </tr>
  </xsl:variable>
  
  <xsl:variable name="cell-sequence" select="document('')/*/xsl:variable[@name='table-layout']/tr/th"/>
  
  <xsl:template match="oscal:catalog | oscal:group">
    <div class="{local-name(.)}">
      <xsl:apply-templates select="oscal:title | oscal:group"/>
      <table class="control-group">
        <xsl:copy-of select="$table-layout"/>
      
          
        <xsl:apply-templates select="oscal:control"/>
      </table>
    </div>
  </xsl:template>
  
  <xsl:template match="oscal:title">
    <h2 class="title">
      <xsl:apply-templates/>
    </h2>
  </xsl:template>
  
  <xsl:template match="oscal:declarations"/>
    
    <xsl:template match="oscal:title" mode="title">
      <xsl:value-of select="."/>
    </xsl:template>

  <xsl:template match="oscal:control">
    <xsl:variable name="me" select="."/>
    <tr class="control">
      <xsl:copy-of select="@id"/>
      <xsl:for-each select="$cell-sequence">
        <xsl:variable name="who" select="."/>
        <xsl:variable name="cell" select="$me/*[contains(@class,$who)]"/>
        
        <xsl:variable name="empty">
          <xsl:if test="not($cell)"> empty</xsl:if>
        </xsl:variable>
        
        <td class="{$who}{$empty}">
          <xsl:apply-templates select="$cell"/>
        </td>
      </xsl:for-each>
    </tr>
  </xsl:template>
  
  <xsl:template match="oscal:control/*">
      <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="oscal:p">
    <p class="p">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="oscal:assign">
      <em class="assign">
        <xsl:apply-templates/>
    </em>
  </xsl:template>

  <xsl:template match="oscal:ol">
    <ol class="ol">
      <xsl:apply-templates/>
    </ol>
  </xsl:template>
  <xsl:template match="oscal:li">
    <li class="li">
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  
  <xsl:template match="oscal:xref">
    <a class="xref">
      <xsl:copy-of select="@href"/>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  
<!-- No references in mapping document. -->
  <xsl:template match="oscal:references"/>
  
  <xsl:template match="oscal:ref">
    <div class="ref">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="oscal:std">
    <p class="std">
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="oscal:withdrawn">
    <span class="withdrawn">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="oscal:em">
    <em class="em">
      <xsl:apply-templates/>
    </em>
  </xsl:template>
  <xsl:template match="oscal:select">
    <div class="select">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="oscal:choice">
    <p class="choice">
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <xsl:template match="oscal:citation">
    <p class="citation">
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <xsl:template match="oscal:div">
    <section class="div">
      <xsl:apply-templates/>
    </section>
  </xsl:template>
  <xsl:template match="oscal:code">
    <code class="code">
      <xsl:apply-templates/>
    </code>
  </xsl:template>
  <xsl:template match="oscal:q">
    <q class="q">
      <xsl:apply-templates/>
    </q>
  </xsl:template>
  
  
</xsl:stylesheet>