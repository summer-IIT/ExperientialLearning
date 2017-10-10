public without sharing class IITAddressHandler { //Handles IIT Address custom object manipulation

	@TestVisible
	private static Map<String, IITAddressMapping__c> addressMappings;
	@TestVisible
	private static Map<String, IIT_Address_Replacement__c> addressReplacementMappings;
	@TestVisible
	private static Map<String, String> countryMappings;
	@TestVisible
	private static Pattern noNumbers;	

static {//Static constructor
	addressMappings = IITAddressMapping__c.getAll(); //Get all addresses defined in custom settings
	addressReplacementMappings = IIT_Address_Replacement__c.getAll(); //Get all addresses replacements defined in custom settings
	IITAddressHandler.validateAddressMappings(); //validate address mappings
	IITAddressHandler.removeDisabledMappings(); //Remove disabled mappings
}
	
//Mapping section
	public static void validateAddressMappings() {//Validates address mappings
		Map<String,Schema.SobjectField> contactFields = Schema.SobjectType.Contact.fields.getMap(); //Get all of the fields for Contacts, cache this later

		//Loop through setting definitions
		for(IITAddressMapping__c addressMapping : addressMappings.values() ) {
			try {
				if(IITDynamicApexHandler.checkDynamicField(contactFields.get(addressMapping.Street_API_Name__c)) == IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST
				|| IITDynamicApexHandler.checkDynamicField(contactFields.get(addressMapping.City_API_Name__c)) == IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST
				|| IITDynamicApexHandler.checkDynamicField(contactFields.get(addressMapping.Country_API_Name__c)) == IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST
				|| IITDynamicApexHandler.checkDynamicField(contactFields.get(addressMapping.Postal_Code_API_Name__c)) == IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST
				|| IITDynamicApexHandler.checkDynamicField(contactFields.get(addressMapping.State_API_Name__c)) == IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST
				||	(String.isBlank(addressMapping.County_API_Name__c) == false
					&& IITDynamicApexHandler.checkDynamicField(contactFields.get(addressMapping.County_API_Name__c)) == IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST
					)
				||	(String.isBlank(addressMapping.Start_Date_API_Name__c) == false
					&& IITDynamicApexHandler.checkDynamicField(contactFields.get(addressMapping.Start_Date_API_Name__c)) == IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST
					)
				||	(String.isBlank(addressMapping.End_Date_API_Name__c) == false
					&& IITDynamicApexHandler.checkDynamicField(contactFields.get(addressMapping.End_Date_API_Name__c)) == IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST
					)
				||	(String.isBlank(addressMapping.Activity_Date_API_Name__c) == false
					&& IITDynamicApexHandler.checkDynamicField(contactFields.get(addressMapping.Activity_Date_API_Name__c)) == IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST
					)
				) {
					addressMapping.Disable__c = true;
				}
				
				IITExceptionHandler.forceException();
			} catch(Exception exceptionCaught) {
				IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			}
		}
	}

	public static void removeDisabledMappings() {//removes disabled mappings from the address map.
		Set<String> removeMappings = new Set<String>();//Initialize list of address mappings to remove
		
		for(String addressMapping : addressMappings.keySet()) {
			if(addressMappings.get(addressMapping).Disable__c) {//Check to see if the mapping is disabled
				removeMappings.add(addressMapping); //Addmapping to list of those to remove
			}
		}
		
		addressMappings.keySet().removeAll(removeMappings); //Remove all invalid address mappings

		removeMappings.clear(); //clear mappings to remove

		for(String addressReplacementMapping : addressReplacementMappings.keySet()) {
			if(addressReplacementMappings.get(addressReplacementMapping).Disable__c) {//Check to see if the mapping is disabled
				removeMappings.add(addressReplacementMapping); //Add mapping to list of those to remove
			}
		}
		
		addressReplacementMappings.keySet().removeAll(removeMappings); //Remove all invalid address replacement mappings
	}

	public static Map<String,String> getCountryMap() {//Return the country map from the org cache or generate it if it is not present
		if(IITAddressHandler.countryMappings != null) {//Check that country mappings aren't locally cached
			return IITAddressHandler.countryMappings; //return the country mapping from the static strongly typed list
		}

		//Map<String,String> countryMapping = (Map<String,String>)Cache.Org.get('countryMap'); //Pull the mapping from the org cache and assign it to the static strongly typed map

		//if(countryMapping != null) {//if we have a country map in the cache
		//	IITAddressHandler.countryMappings = countryMapping; //assign the map from the cache
		//	return IITAddressHandler.countryMappings; //return the country map
		//}

		IITAddressHandler.countryMappings = IITAddressHandler.generateCountryMap(); //Generate the mapping, assign it to the org cache, and to the static strongly typed map
		return IITAddressHandler.countryMappings; //return the country map
	}

	public static Map<String,String> generateCountryMap() {//push the country map to the org cache
		Map<String,String> countryMap = new Map<String,String>();
		countryMap.put('AD','Andorra');
		countryMap.put('AE','United Arab Emirates');
		countryMap.put('AF','Afghanistan');
		countryMap.put('AG','Antigua and Barbuda');
		countryMap.put('AI','Anguilla');
		countryMap.put('AL','Albania');
		countryMap.put('AM','Armenia');
		countryMap.put('AO','Angola');
		countryMap.put('AQ','Antarctica');
		countryMap.put('AR','Argentina');
		countryMap.put('AT','Austria');
		countryMap.put('AU','Australia');
		countryMap.put('AW','Aruba');
		countryMap.put('AX','Aland Islands');
		countryMap.put('AZ','Azerbaijan');
		countryMap.put('BA','Bosnia and Herzegovina');
		countryMap.put('BB','Barbados');
		countryMap.put('BD','Bangladesh');
		countryMap.put('BE','Belgium');
		countryMap.put('BF','Burkina Faso');
		countryMap.put('BG','Bulgaria');
		countryMap.put('BH','Bahrain');
		countryMap.put('BI','Burundi');
		countryMap.put('BJ','Benin');
		countryMap.put('BL','Saint Barthélemy');
		countryMap.put('BM','Bermuda');
		countryMap.put('BN','Brunei Darussalam');
		countryMap.put('BO','Bolivia, Plurinational State of');
		countryMap.put('BQ','Bonaire, Sint Eustatius and Saba');
		countryMap.put('BR','Brazil');
		countryMap.put('BS','Bahamas');
		countryMap.put('BT','Bhutan');
		countryMap.put('BV','Bouvet Island');
		countryMap.put('BW','Botswana');
		countryMap.put('BY','Belarus');
		countryMap.put('BZ','Belize');
		countryMap.put('CA','Canada');
		countryMap.put('CC','Cocos (Keeling) Islands');
		countryMap.put('CD','Congo, the Democratic Republic of the');
		countryMap.put('CF','Central African Republic');
		countryMap.put('CG','Congo');
		countryMap.put('CH','Switzerland');
		countryMap.put('CI','Cote d\'Ivoire');
		countryMap.put('CK','Cook Islands');
		countryMap.put('CL','Chile');
		countryMap.put('CM','Cameroon');
		countryMap.put('CN','China');
		countryMap.put('CO','Colombia');
		countryMap.put('CR','Costa Rica');
		countryMap.put('CU','Cuba');
		countryMap.put('CV','Cape Verde');
		countryMap.put('CW','Curaçao');
		countryMap.put('CX','Christmas Island');
		countryMap.put('CY','Cyprus');
		countryMap.put('CZ','Czech Republic');
		countryMap.put('DE','Germany');
		countryMap.put('DJ','Djibouti');
		countryMap.put('DK','Denmark');
		countryMap.put('DM','Dominica');
		countryMap.put('DO','Dominican Republic');
		countryMap.put('DZ','Algeria');
		countryMap.put('EC','Ecuador');
		countryMap.put('EE','Estonia');
		countryMap.put('EG','Egypt');
		countryMap.put('EH','Western Sahara');
		countryMap.put('ER','Eritrea');
		countryMap.put('ES','Spain');
		countryMap.put('ET','Ethiopia');
		countryMap.put('FI','Finland');
		countryMap.put('FJ','Fiji');
		countryMap.put('FK','Falkland Islands (Malvinas)');
		countryMap.put('FO','Faroe Islands');
		countryMap.put('FR','France');
		countryMap.put('GA','Gabon');
		countryMap.put('GB','United Kingdom');
		countryMap.put('GD','Grenada');
		countryMap.put('GE','Georgia');
		countryMap.put('GF','French Guiana');
		countryMap.put('GG','Guernsey');
		countryMap.put('GH','Ghana');
		countryMap.put('GI','Gibraltar');
		countryMap.put('GL','Greenland');
		countryMap.put('GM','Gambia');
		countryMap.put('GN','Guinea');
		countryMap.put('GP','Guadeloupe');
		countryMap.put('GQ','Equatorial Guinea');
		countryMap.put('GR','Greece');
		countryMap.put('GS','South Georgia and the South Sandwich Islands');
		countryMap.put('GT','Guatemala');
		countryMap.put('GW','Guinea-Bissau');
		countryMap.put('GY','Guyana');
		countryMap.put('HM','Heard Island and McDonald Islands');
		countryMap.put('HN','Honduras');
		countryMap.put('HR','Croatia');
		countryMap.put('HT','Haiti');
		countryMap.put('HU','Hungary');
		countryMap.put('ID','Indonesia');
		countryMap.put('IE','Ireland');
		countryMap.put('IL','Israel');
		countryMap.put('IM','Isle of Man');
		countryMap.put('IN','India');
		countryMap.put('IO','British Indian Ocean Territory');
		countryMap.put('IQ','Iraq');
		countryMap.put('IR','Iran, Islamic Republic of');
		countryMap.put('IS','Iceland');
		countryMap.put('IT','Italy');
		countryMap.put('JE','Jersey');
		countryMap.put('JM','Jamaica');
		countryMap.put('JO','Jordan');
		countryMap.put('JP','Japan');
		countryMap.put('KE','Kenya');
		countryMap.put('KG','Kyrgyzstan');
		countryMap.put('KH','Cambodia');
		countryMap.put('KI','Kiribati');
		countryMap.put('KM','Comoros');
		countryMap.put('KN','Saint Kitts and Nevis');
		countryMap.put('KP','Korea, Democratic People\'s Republic of');
		countryMap.put('KR','Korea, Republic of');
		countryMap.put('KW','Kuwait');
		countryMap.put('KY','Cayman Islands');
		countryMap.put('KZ','Kazakhstan');
		countryMap.put('LA','Lao People\'s Democratic Republic');
		countryMap.put('LB','Lebanon');
		countryMap.put('LC','Saint Lucia');
		countryMap.put('LI','Liechtenstein');
		countryMap.put('LK','Sri Lanka');
		countryMap.put('LR','Liberia');
		countryMap.put('LS','Lesotho');
		countryMap.put('LT','Lithuania');
		countryMap.put('LU','Luxembourg');
		countryMap.put('LV','Latvia');
		countryMap.put('LY','Libya');
		countryMap.put('MA','Morocco');
		countryMap.put('MC','Monaco');
		countryMap.put('MD','Moldova, Republic of');
		countryMap.put('ME','Montenegro');
		countryMap.put('MF','Saint Martin (French part)');
		countryMap.put('MG','Madagascar');
		countryMap.put('MK','Macedonia, the former Yugoslav Republic of');
		countryMap.put('ML','Mali');
		countryMap.put('MM','Myanmar');
		countryMap.put('MN','Mongolia');
		countryMap.put('MO','Macao');
		countryMap.put('MQ','Martinique');
		countryMap.put('MR','Mauritania');
		countryMap.put('MS','Montserrat');
		countryMap.put('MT','Malta');
		countryMap.put('MU','Mauritius');
		countryMap.put('MV','Maldives');
		countryMap.put('MW','Malawi');
		countryMap.put('MX','Mexico');
		countryMap.put('MY','Malaysia');
		countryMap.put('MZ','Mozambique');
		countryMap.put('NA','Namibia');
		countryMap.put('NC','New Caledonia');
		countryMap.put('NE','Niger');
		countryMap.put('NF','Norfolk Island');
		countryMap.put('NG','Nigeria');
		countryMap.put('NI','Nicaragua');
		countryMap.put('NL','Netherlands');
		countryMap.put('NO','Norway');
		countryMap.put('NP','Nepal');
		countryMap.put('NR','Nauru');
		countryMap.put('NU','Niue');
		countryMap.put('NZ','New Zealand');
		countryMap.put('OM','Oman');
		countryMap.put('PA','Panama');
		countryMap.put('PE','Peru');
		countryMap.put('PF','French Polynesia');
		countryMap.put('PG','Papua New Guinea');
		countryMap.put('PH','Philippines');
		countryMap.put('PK','Pakistan');
		countryMap.put('PL','Poland');
		countryMap.put('PM','Saint Pierre and Miquelon');
		countryMap.put('PN','Pitcairn');
		countryMap.put('PS','Palestine');
		countryMap.put('PT','Portugal');
		countryMap.put('PY','Paraguay');
		countryMap.put('QA','Qatar');
		countryMap.put('RE','Reunion');
		countryMap.put('RO','Romania');
		countryMap.put('RS','Serbia');
		countryMap.put('RU','Russian Federation');
		countryMap.put('RW','Rwanda');
		countryMap.put('SA','Saudi Arabia');
		countryMap.put('SB','Solomon Islands');
		countryMap.put('SC','Seychelles');
		countryMap.put('SD','Sudan');
		countryMap.put('SE','Sweden');
		countryMap.put('SG','Singapore');
		countryMap.put('SH','Saint Helena, Ascension and Tristan da Cunha');
		countryMap.put('SI','Slovenia');
		countryMap.put('SJ','Svalbard and Jan Mayen');
		countryMap.put('SK','Slovakia');
		countryMap.put('SL','Sierra Leone');
		countryMap.put('SM','San Marino');
		countryMap.put('SN','Senegal');
		countryMap.put('SO','Somalia');
		countryMap.put('SR','Suriname');
		countryMap.put('SS','South Sudan');
		countryMap.put('ST','Sao Tome and Principe');
		countryMap.put('SV','El Salvador');
		countryMap.put('SX','Sint Maarten (Dutch part)');
		countryMap.put('SY','Syrian Arab Republic');
		countryMap.put('SZ','Swaziland');
		countryMap.put('TC','Turks and Caicos Islands');
		countryMap.put('TD','Chad');
		countryMap.put('TF','French Southern Territories');
		countryMap.put('TG','Togo');
		countryMap.put('TH','Thailand');
		countryMap.put('TJ','Tajikistan');
		countryMap.put('TK','Tokelau');
		countryMap.put('TL','Timor-Leste');
		countryMap.put('TM','Turkmenistan');
		countryMap.put('TN','Tunisia');
		countryMap.put('TO','Tonga');
		countryMap.put('TR','Turkey');
		countryMap.put('TT','Trinidad and Tobago');
		countryMap.put('TV','Tuvalu');
		countryMap.put('TW','Taiwan');
		countryMap.put('TZ','Tanzania, United Republic of');
		countryMap.put('UA','Ukraine');
		countryMap.put('UG','Uganda');
		countryMap.put('US','United States');
		countryMap.put('UY','Uruguay');
		countryMap.put('UZ','Uzbekistan');
		countryMap.put('VA','Holy See (Vatican City State)');
		countryMap.put('VC','Saint Vincent and the Grenadines');
		countryMap.put('VE','Venezuela, Bolivarian Republic of');
		countryMap.put('VG','Virgin Islands, British');
		countryMap.put('VN','Viet Nam');
		countryMap.put('VU','Vanuatu');
		countryMap.put('WF','Wallis and Futuna');
		countryMap.put('WS','Samoa');
		countryMap.put('YE','Yemen');
		countryMap.put('YT','Mayotte');
		countryMap.put('ZA','South Africa');
		countryMap.put('ZM','Zambia');
		countryMap.put('ZW','Zimbabwe');
		countryMap.put('United States of America','United States');
		countryMap.put('USA','United States');
		countryMap.put('Iran','Iran, Islamic Republic of');
		countryMap.put('Iran (Islamic Republic Of)','Iran, Islamic Republic of');
		countryMap.put('Venezuela','Venezuela, Bolivarian Republic of');
		countryMap.put('Palestine, State of','Palestine');
		countryMap.put('Palestinian Territory, Occupied','Palestine');
		countryMap.put('Tanzania','Tanzania, United Republic of');
		countryMap.put('Bolivia','Bolivia, Plurinational State of');
		countryMap.put('South Korea','Korea, Republic of');
		countryMap.put('Korea (Rok)','Korea, Republic of');
		countryMap.put('Taiwan, Province Of China','Taiwan');
		countryMap.put('Gambia, The','Gambia');
		countryMap.put('Bahamas, The','Bahamas');
		countryMap.put('Macedonia','Macedonia, the former Yugoslav Republic of');
		countryMap.put('St Vincent and the Grenadines','Saint Vincent and the Grenadines');
		countryMap.put('Virgin Islands (British)','Virgin Islands, British');
		countryMap.put('British Virgin Islands','Virgin Islands, British');
		countryMap.put('P.R.China','China');
		countryMap.put('Great Britain and Northern Ireland','United Kingdom');
		countryMap.put('St Lucia Island','Saint Lucia');
		countryMap.put('Saint Lucia Island','Saint Lucia');
		countryMap.put('Brunei','Brunei Darussalam');//common app

		//Cache.Org.put('countryMap',countryMap);
		return countryMap;
	}

/*********************
Sanitization section
*********************/
	/*
	Sanitizes all the addresses on a contact record.
	*/
	public static void sanitizeContactAddresses(Contact contact, Contact oldContact) {
		for(String addressMapping : addressMappings.keySet()) { //Iterate through each phone mapping
			IITAddressMapping__c addressMappingObject = addressMappings.get(addressMapping); //Pull the address mapping down.

			if(IITAddressHandler.shouldUseAddressMapping(contact,oldContact,addressMappingObject)) {//Check that the address has changed and should use the mapping
				IITAddressHandler.sanitizeContactAgainstMapping(addressMappingObject, contact);
			}
		}
	}

	public static void sanitizeContactAgainstMapping(IITAddressMapping__c addressMappingObject, Contact contact) {
		contact.put(addressMappingObject.Country_API_Name__c,IITAddressHandler.sanitizeCountry((String)contact.get(addressMappingObject.Country_API_Name__c)));//Assign the sanitized country
		contact.put(addressMappingObject.Street_API_Name__c, IITAddressHandler.formatString((String)contact.get(addressMappingObject.Street_API_Name__c), (String)contact.get(addressMappingObject.Country_API_Name__c) != 'United States'));//Assign the sanitized string
		contact.put(addressMappingObject.Activity_Date_API_Name__c, System.today());//Timestamp the address
	}

	public static String sanitizeCountry(string countryToSanitize) { //Sanitizes a phone number and returns it.
	//Returns null if the country is blank
		if( String.isBlank(countryToSanitize)
		|| countryToSanitize == 'Other'
		) {//Check for null or empty or Other
           return null; //return a null string
        }

        IITAddressHandler.getCountryMap(); //Obtain the country map if it does not exist and push it to the static method in the namespace

        if( IITAddressHandler.countryMappings.containsKey(countryToSanitize) ) {//check that the country map contains the 
        	return IITAddressHandler.countryMappings.get(countryToSanitize); //return the sanitized country
        }
		
		return countryToSanitize; //return the santized string
	}

	public static String formatString(String stringToSanitize, boolean isInternational) {
		if( String.isBlank(stringToSanitize) ) {
			return null;
		}

		stringToSanitize = stringToSanitize.trim(); //format spacing, and split the string by spaces

		List<String> listToModify = new List<String>(); //stringToSanitize.split(' '); //Split the string on spaces
		//scrub out the bad addresses. Turned off until we can validate.
		//for(Integer i = 0; i < listToModify.size(); i++) {//iterate through each string
		//	if(listToModify[i].indexOf('\r\n') > -1) { //Check for linebreaks as we want to split on those too
		//		List<String> subListToModify = listToModify[i].split('\r\n'); //split on newlines
				
		//		for(Integer j=0; j< subListToModify.size(); j++) {//Iterate through each string
		//			subListToModify[j] = IITAddressHandler.enforceCapitalization(subListToModify[j]); //Capitalize the string.
		//		}
				
		//		listToModify[i] = String.join(subListToModify,'\r\n'); //join the string back up with the newline characters between
		//	} else {
		//		listToModify[i] = IITAddressHandler.enforceCapitalization(listToModify[i]); //Capitalize the string.
		//	}
		//}

		//stringToSanitize = String.join(listToModify,' '); //join the string back up with space characters between.

		for(IIT_Address_Replacement__c addressReplacement: addressReplacementMappings.values()) {
			if(isInternational == addressReplacement.International__c
			|| isInternational != addressReplacement.US__c
			) {
				stringToSanitize = stringToSanitize.replaceAll(addressReplacement.Name
					, (String.isBlank(addressReplacement.Replacement_Value__c) ? '' : addressReplacement.Replacement_Value__c )
				); //replace garbage
			}
		}

		if(isInternational
		&& stringToSanitize.length() > 60 //over the FSA atlas one line limit
		) {//only modify address streets we can control for the feed.
			listToModify = stringToSanitize.split('\r\n'); //split on line breaks

			if(listToModify.size() > 1) {//We have at least one line break
				for(Integer i = 0; i < listToModify.size(); i++) {//For each line break
					if(listToModify[i].length() > 60) {//Check that the string's length isn't over Atlas's limit
						listToModify[i] = IITAddressHandler.insertEndlines(listToModify[i]); //Insert a line break
					}
				}

				stringToSanitize = String.join(listToModify,'\r\n'); //join the string back up with newline characters between.
			} else { //It's all on one line. Fix that
				stringToSanitize = IITAddressHandler.insertEndlines(stringToSanitize); //insert endlines into the string where appropriate
			}
		}

		return stringToSanitize;
	}

	public static string insertEndlines(String stringToSanitize) {//Inserts an endline before the 60th character of the string
		Integer splitIndexSpace = stringToSanitize.lastIndexOfIgnoreCase(' ', 59); //find the last space
		Integer splitIndexComma = stringToSanitize.lastIndexOfIgnoreCase(',', 59); //find the last comma

		if(splitIndexComma != -1
		&& splitIndexComma > splitIndexSpace
		) {//last comma is later than last space and actually exists
			stringToSanitize = stringToSanitize.substring(0,splitIndexComma) + '\r\n' + stringToSanitize.substring(splitIndexComma); //insert an endline after the last comma
		} else if(splitindexSpace != -1) { //last space is later than or equal to last comma and actually exists
			stringToSanitize = stringToSanitize.substring(0,splitIndexSpace) + '\r\n' + stringToSanitize.substring(splitIndexSpace); //insert an endline after the last space
		}

		return stringToSanitize;
	}

	public static String enforceCapitalization(String stringToSanitize) {
		if( Pattern.matches('\\D+',stringToSanitize) == false //has numbers
		|| stringToSanitize.contains('\\') //Has a backslash
		|| stringToSanitize.contains('/') //Has a forwardslash
		||	(stringToSanitize.isAllUpperCase() //Is all uppercase
			&& stringToSanitize.length() < 7 //length less than 4
			)
		) {
			return stringToSanitize; //Do nothing
		}
		
		return stringToSanitize.toLowerCase().capitalize(); //Capitalize it
	}

	public static boolean shouldUseAddressMapping(Contact newContact, Contact oldContact, IITAddressMapping__c addressMappingObject) {
		return ( (String.isBlank((String)newContact.get(addressMappingObject.Street_API_Name__c))
			&& String.isBlank((String)newContact.get(addressMappingObject.City_API_Name__c))
			&& String.isBlank((String)newContact.get(addressMappingObject.State_API_Name__c))
			&& String.isBlank((String)newContact.get(addressMappingObject.Postal_Code_API_Name__c))
			&& String.isBlank((String)newContact.get(addressMappingObject.Country_API_Name__c))
			&&	(String.isBlank(addressMappingObject.County_API_Name__c)
				|| String.isBlank((String)newContact.get(addressMappingObject.County_API_Name__c))
				)
			) == false
		&& (oldContact == null
			|| oldContact.get(addressMappingObject.Street_API_Name__c) != newContact.get(addressMappingObject.Street_API_Name__c)
			|| oldContact.get(addressMappingObject.City_API_Name__c)!= newContact.get(addressMappingObject.City_API_Name__c)
			|| oldContact.get(addressMappingObject.State_API_Name__c) != newContact.get(addressMappingObject.State_API_Name__c)
			|| oldContact.get(addressMappingObject.Postal_Code_API_Name__c) != newContact.get(addressMappingObject.Postal_Code_API_Name__c)
			|| oldContact.get(addressMappingObject.Country_API_Name__c) != newContact.get(addressMappingObject.Country_API_Name__c)
			|| 	(String.isBlank(addressMappingObject.County_API_Name__c)
				|| oldContact.get(addressMappingObject.County_API_Name__c) != newContact.get(addressMappingObject.County_API_Name__c)
				)
			)
		);
	}

//Update and insert section
	public static void processAddresses(List<Contact> newContacts, Map<id,Contact> oldContacts) {//Creates a new address object and adds it to a list of contacts on insert
		try {
			Map<String,IIT_Address__c> addressesToProcess = new Map<String,IIT_Address__c>(); //Initialize a map of address records

			//Get field definitions
			for(Contact newContact: newContacts) {//Iterate through contacts.  Note that the order is in ascending priority
				Contact oldContact = null; //Initialize old contact
				
				if(oldContacts != null) {//Check that the old contents map exists
					oldContact = oldContacts.get(newContact.id); //Get the old contact.
				}

				for(String addressMapping : addressMappings.keySet()) {//Iterate through each address mapping
					IITAddressMapping__c addressMappingObject = addressMappings.get(addressMapping); //Pull the address mapping down.

					if(IITAddressHandler.shouldUseAddressMapping(newContact,oldContact,addressMappingObject)) {//Check that address fields in the set have been populated and have changed
						IIT_Address__c addressToProcess = new IIT_Address__c(IIT_Contact__c = newContact.id
						, IIT_Address_Type__c = addressMappingObject.Address_Type__c
						, IIT_Street__c = (String)newContact.get(addressMappingObject.Street_API_Name__c)
						, IIT_City__c = (String)newContact.get(addressMappingObject.City_API_Name__c)
						, IIT_County__c = (String)newContact.get(addressMappingObject.County_API_Name__c)
						, IIT_State__c = (String)newContact.get(addressMappingObject.State_API_Name__c)
						, IIT_Postal_Code__c = (String)newContact.get(addressMappingObject.Postal_Code_API_Name__c)
						, IIT_Country__c = (String)newContact.get(addressMappingObject.Country_API_Name__c)
						, IIT_Start_Date__c = (String.isBlank(addressMappingObject.Start_Date_API_Name__c) ? null : (Date)newContact.get(addressMappingObject.Start_Date_API_Name__c))
						, IIT_End_Date__c = (String.isBlank(addressMappingObject.End_Date_API_Name__c) ? null : (Date)newContact.get(addressMappingObject.End_Date_API_Name__c))
						);
						addressesToProcess.put(IITAddressHandler.getAddressMapKey(addressToProcess),addressToProcess); //Add the address to the list for use in processing
					}
				}
			}
			
			if(oldContacts == null) {//Don't check for other records, just create. This is for inserts.
				IITAddressHandler.createAddressesFromList(addressesToProcess.values()); //Insert address records
			} else {//Check for other records and potentially update them.
				IITAddressHandler.processAddressesFromMap(addressesToProcess); //Create or update address records
			}
			IITExceptionHandler.forceException();
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
//Insert section
	public static void createAddressesFromList(List<IIT_Address__c> addressesToCreate) {
		IITAddressHandler.performInsert(addressesToCreate);
	}

	public static void performInsert(List<IIT_Address__c> addressesToInsert) {
		try {
			Insert addressesToInsert; //Perform database insert on the desired records.
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(DMLException dmlExceptionCaught) {//Catch dml errors
			IITExceptionHandler.sendDMLExceptionEmail(dmlExceptionCaught); //Send dml specific exception email
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
//Update section	
	public static void processAddressesFromMap(Map<String,IIT_Address__c> addressesToProcess) {//Iterates through a map of address objects and creates or updates them
		List<IIT_Address__c> addressesToInsert = new List<IIT_Address__c>(); //Create a list of address records to insert
		Map<id,IIT_Address__c> addressesToUpdate = new Map<id,IIT_Address__c>(); //Create a map to verify if an address record is already in the update list.
		Set<id> contactIdsToCheck = new Set<id>(); //Contact Ids to pull

		for(IIT_Address__c addressToProcess: addressesToProcess.values()) {//Iterate through the address objects
			contactIdsToCheck.add(addressToProcess.id); //Add the address's contact id to the set
		}

		Map<String,IIT_Address__c> contactCurrentAddressMap = IITAddressHandler.getContactAddresses(contactIdsToCheck); //Get a map of all existing addresses for the list of contacts

		for(String addressKey : addressesToProcess.keySet()) {//Iterate through every address key
			IIT_Address__c newContactAddress = addressesToProcess.get(addressKey);
			IIT_Address__c oldContactAddress = contactCurrentAddressMap.get(addressKey); //Get the matching address or null from the old addresses

			if(oldContactAddress != null
			&& IITAddressHandler.processAddressMatch(newContactAddress,oldContactAddress)
			) {//a record was pulled from the map
				addressesToUpdate.put(oldContactAddress.id, oldContactAddress);
			} else {
				addressesToInsert.add(newContactAddress);
			}
		}

		IITAddressHandler.performInsert(addressesToInsert);//Insert the appopriate addresses
		IITAddressHandler.performUpdate(addressesToUpdate.values());//Update appropriate addresses
	}

	public static void performUpdate(List<IIT_Address__c> addressesToUpdate) {
		try {
			Update addressesToUpdate; //Perform database insert on the desired records.
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(DMLException dmlExceptionCaught) {//Catch dml errors
			IITExceptionHandler.sendDMLExceptionEmail(dmlExceptionCaught); //Send dml specific exception email
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
	
	public static Map<String,IIT_Address__c> getContactAddresses(Set<Id> contactsToMap) {//Generates a map of contact ids to associated address record list
		Map<String,IIT_Address__c> contactAddressMap = new Map<String,IIT_Address__c>(); //Make new map
		List<Contact> contacts = [SELECT id,
			(SELECT id
			, IIT_Contact__c
			, IIT_Street__c
			, IIT_City__c
			, IIT_County__c
			, IIT_State__c
			, IIT_Postal_Code__c
			, IIT_Start_Date__c
			, IIT_End_Date__c
			, IIT_Country__c
			, IIT_Address_Type__c
			FROM Contact.IIT_Addresses__r)
		FROM Contact
		WHERE id IN : contactsToMap
		FOR UPDATE]; //Get contact all related address manipulation data.
		
		for(Contact newContact: contacts) { //Iterate through all of the contacts.
			for(IIT_Address__c contactAddress :  newContact.IIT_Addresses__r) {//iterate through every address
				contactAddressMap.put(IITAddressHandler.getAddressMapKey(contactAddress),contactAddress);//Map the address using its key
			}
		}
		
		return contactAddressMap; //return the completed address map.
	}

    public static String getAddressMapKey(IIT_Address__c addressForKey) {//generates an address key
    	return addressForKey.IIT_Contact__c
    	+ (String.isBlank(addressForKey.IIT_Address_Type__c) ? '~' : addressForKey.IIT_Address_Type__c + '~')
    	+ (String.isBlank(addressForKey.IIT_Street__c) ? '~' : addressForKey.IIT_Street__c + '~')
    	+ (String.isBlank(addressForKey.IIT_City__c) ? '~' : addressForKey.IIT_City__c + '~')
    	+ (String.isBlank(addressForKey.IIT_State__c) ? '~' : addressForKey.IIT_State__c + '~')
    	+ (String.isBlank(addressForKey.IIT_Postal_Code__c) ? '~' : addressForKey.IIT_Postal_Code__c + '~')
    	+ (String.isBlank(addressForKey.IIT_County__c) ? '~' : addressForKey.IIT_County__c + '~')
    	+ (String.isBlank(addressForKey.IIT_Country__c) ? '~' : addressForKey.IIT_Country__c + '~')
    	;
    }
	
	public static boolean processAddressMatch(IIT_Address__c addressToMatch, IIT_Address__c matchedAddress) {//Checks an address record to see if it is a match
	//Returns true if the matched address is updated.
		boolean updateOldAddress = false;

		if(matchedAddress.IIT_Start_Date__c != addressToMatch.IIT_Start_Date__c) {//Check that the start date is different
			updateOldAddress = true;
			matchedAddress.IIT_Start_Date__c = addressToMatch.IIT_Start_Date__c; //Set the matched address's start date to the new start date
		}

		if(matchedAddress.IIT_End_Date__c != addressToMatch.IIT_End_Date__c) {//Check that the end date is different
			updateOldAddress = true;
			matchedAddress.IIT_End_Date__c = addressToMatch.IIT_End_Date__c; //Set the matched address's end date to the new end date
		}

		return updateOldAddress;
	}
}