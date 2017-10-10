@isTest
public without sharing class DataFactoryTest {
	public static TargetX_SRMb__Test__c createTest() {
		// create a single test object
		String testType = DataFactoryTestTypes.createTestType();
		TargetX_SRMb__Test__c test = new TargetX_SRMb__Test__c(
			Name = 'Test test',
			TargetX_SRMb__Test__c = testType
		);
		
		return test;
	}
	
	public static List<TargetX_SRMb__Test__c> createTestList(Integer numberOfTests) {
		// create a list of test objects
		List<String> testTypes = DataFactoryTestTypes.createTestTypes();
		List<TargetX_SRMb__Test__c> tests = new List<TargetX_SRMb__Test__c>();
		
		for(Integer i = 0; i < numberOfTests; i++) {
			TargetX_SRMb__Test__c test = new TargetX_SRMb__Test__c(
				Name = 'Test test ' + String.valueof(i),
				TargetX_SRMb__Test__c = testTypes[math.mod(i, testTypes.size())]
			);
			
			tests.add(test);
		}
		
		return tests;
	}
	
	public static void addContactToTest(Contact contact, TargetX_SRMb__Test__c test) {
		// add a contact id to an existing test object
		
		// check that the contact has an id
		system.assert(contact.id != null);
		
		test.TargetX_SRMb__Contact__c = contact.id;
	}
	
	public static void addContactListToTestList(List<Contact> contacts, List<TargetX_SRMb__Test__c> tests) {
		// add a contact id from a list of contacts to each test in a list of test objects
		
		// check that each contact has an id and that the lists are the same size
		for(Contact c : contacts) {
			system.assert(c.id != null);
		}
		system.assert(contacts.size() == tests.size());
		
		for(Integer i = 0; i < contacts.size(); i++) {
			tests[i].TargetX_SRMb__Contact__c = contacts[i].id;
		}
	}
	
	public static List<TargetX_SRMb__Test__c> createAndInsertTestsWithContacts(List<Contact> contacts, Integer testsPerContact) {
		// convenience method that wraps various test methods in order to create a list of test objects associated with contacts then inserts the 
		// records into the database
		List<TargetX_SRMb__Test__c> totalTests = new List<TargetX_SRMb__Test__c>();
		
		for(Integer i = 0; i < testsPerContact; i++) {
			List<TargetX_SRMb__Test__c> tests = DataFactoryTest.createTestList(contacts.size());
			DataFactoryTest.addContactListToTestList(contacts, tests);
			
			totalTests.addAll(tests);
		}
		
		Database.SaveResult[] results = Database.insert(totalTests);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(results);
		
		return totalTests;
	}
}