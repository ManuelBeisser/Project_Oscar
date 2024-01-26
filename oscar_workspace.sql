SELECT ?mintLabel (COUNT(DISTINCT ?type) AS ?typeCount) ?weightAvg ?lat ?long WHERE {
 {
   SELECT ?mint (AVG(xsd:decimal(?weight)) AS ?weightAvg) WHERE {
     ?coin nmo:hasTypeSeriesItem ?type ;
           nmo:hasWeight ?weight .
     ?type nmo:hasAuthority nm:augustus ;
           nmo:hasDenomination nm:denarius ;
           dcterms:source nm:ric ;
           nmo:hasMint ?mint .
   } GROUP BY ?mint
 }
 ?type nmo:hasAuthority nm:augustus ;
       nmo:hasDenomination nm:denarius ;
       dcterms:source nm:ric ;
       nmo:hasMint ?mint .
 ?mint skos:prefLabel ?mintLabel .
 FILTER langMatches(lang(?mintLabel), "en")

 OPTIONAL {
   ?mint geo:location ?geoLocation .
   ?geoLocation geo:lat ?lat ;
                geo:long ?long .
 }
} GROUP BY ?mintLabel ?weightAvg ?lat ?long ORDER BY ?mintLabel


PREFIX crm:  <http://www.cidoc-crm.org/cidoc-crm/>
PREFIX dcterms:  <http://purl.org/dc/terms/>
PREFIX dcmitype:  <http://purl.org/dc/dcmitype/>
PREFIX foaf:  <http://xmlns.com/foaf/0.1/>
PREFIX geo:  <http://www.w3.org/2003/01/geo/wgs84_pos#>
PREFIX nm:  <http://nomisma.org/id/>
PREFIX nmo:  <http://nomisma.org/ontology#>
PREFIX org:  <http://www.w3.org/ns/org#>
PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs:  <http://www.w3.org/2000/01/rdf-schema#>
PREFIX skos:  <http://www.w3.org/2004/02/skos/core#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>

SELECT ?objects ?label2 ?weight
WHERE {
?objects nmo:hasTypeSeriesItem ?type;
    nmo:hasWeight ?weight.
?type skos:prefLabel ?label2.
FILTER langMatches(lang(?label2), "en") 
{
	  SELECT DISTINCT ?type 
	WHERE {
		{	
	  ?type dcterms:source nm:oscar;
		nmo:hasStartDate ?startdate;
	    	nmo:hasMint ?mint.
	  	?mint skos:prefLabel ?label.
	FILTER langMatches(lang(?label), "en") 
	FILTER ( ?startdate >= "1138"^^xsd:gYear && ?startdate <= "1350"^^xsd:gYear ) .
		}
	UNION {
	  	?type dcterms:source nm:oscar;
		nmo:hasEndDate ?enddate;
	    	nmo:hasMint ?mint.
	  	?mint skos:prefLabel ?label.
	FILTER langMatches(lang(?label), "en") 
	FILTER ( ?enddate >= "1138"^^xsd:gYear && ?enddate <= "1350"^^xsd:gYear ) .
		}
}
}
}

SELECT DISTINCT ?type ?mint ?startdate ?enddate
WHERE {
	{	
  ?type dcterms:source nm:oscar;
	nmo:hasStartDate ?startdate;
    	nmo:hasMint ?mint.
  	?mint skos:prefLabel ?label.
FILTER langMatches(lang(?label), "en") 
FILTER ( ?startdate >= "1138"^^xsd:gYear && ?startdate <= "1350"^^xsd:gYear ) .
	}
UNION {
  	?type dcterms:source nm:oscar;
	nmo:hasEndDate ?enddate;
    	nmo:hasMint ?mint.
  	?mint skos:prefLabel ?label.
FILTER langMatches(lang(?label), "en") 
FILTER ( ?enddate >= "1138"^^xsd:gYear && ?enddate <= "1350"^^xsd:gYear ) .
	}
}