<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
 <sch:pattern>
     <sch:rule context="tei:sense/tei:bibl">
         <sch:let name="lang" value="ancestor::tei:entry[@xml:lang]/@xml:lang"/>
         <sch:assert test="false()" sqf:fix="fix_bibl" role="warn">
             &lt;bibl&gt; element is not allowed in &lt;sense&gt;.
         </sch:assert>
         
         <sqf:fix id="fix_bibl">
             <sqf:description>
                 <sqf:title>Surround with the element &lt;cit&gt;</sqf:title>
                 <sqf:p>Adds 'cit' element of type 'example' around the 'bibl' element.</sqf:p>
             </sqf:description>
             <sqf:replace target="tei:cit" node-type="element">
                 <xsl:attribute name="type" select="'example'" />
                 <xsl:attribute name="lang" namespace="http://www.w3.org/XML/1998/namespace" select="$lang" />
                 <xsl:text>
                 </xsl:text>
                 <xsl:copy-of select="." />
                 <xsl:text>
                 </xsl:text>
             </sqf:replace>
         </sqf:fix>
     </sch:rule>
     
     <sch:rule context="tei:cit/tei:def">
         <sch:assert test="false()" sqf:fix="fix_def" role="warn">
             &lt;def&gt; element is not allowed in &lt;cit&gt;.
         </sch:assert>
         
         <sqf:fix id="fix_def">
             <sqf:description>
                 <sqf:title>Replace with &lt;gloss&gt; element</sqf:title>
                 <sqf:p>Replaces 'def' element with 'gloss' element.</sqf:p>
             </sqf:description>
             <sqf:replace target="tei:gloss" node-type="element">
                 <xsl:apply-templates mode="copy" select="@*|node()"/>
             </sqf:replace>
         </sqf:fix>
     </sch:rule>
     
 </sch:pattern>
    
    <!-- Template used to copy the current node -->
    <xsl:template match="node() | @*" mode="copy">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="node() | @*" mode="copy"/>
        </xsl:copy>
    </xsl:template>
    
</sch:schema>