public without sharing class IITDynamicApexHandler { //Handles Dynamic Apex Calls

	public static IITDynamicFieldCheckState checkDynamicField(Schema.SobjectField sObjectFieldToCheck) {//Checks whether or not a field exists
		if(sObjectFieldToCheck == null) {
			return IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST;
		} else if( sObjectFieldToCheck.getDescribe().isAccessible() ) {
			return IITDynamicFieldCheckState.FIELD_IS_ACCESSIBLE;
		}
		else {
			return IITDynamicFieldCheckState.FIELD_EXISTS;
		}

	}

	public enum IITDynamicFieldCheckState {
		FIELD_DOES_NOT_EXIST,
		FIELD_EXISTS,
		FIELD_IS_ACCESSIBLE
	}
}