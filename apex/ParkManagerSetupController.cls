public class ParkManagerSetupController {
    
    public class ParkConfig {
        public Boolean campingAllowed {get; set;}
        public Boolean rvAllowed {get; set;}
        public Boolean hasPower {get; set;}
        public Boolean hasWater {get; set;}
        public Boolean hasGrizzlyBears {get; set;}
        public Boolean hasBlackBears {get; set;}
        public Boolean hasBrownBears {get; set;}
        public Integer openHour {get; set;}
        public Integer closeHour {get; set;}
    }  
    
    
    @RemoteAction  
    public static ParkManagerSetupController.ParkConfig createConfig() {
        ParkManagerSetupController.ParkConfig config = new ParkManagerSetupController.ParkConfig();
        config.campingAllowed = false;
        config.rvAllowed = false;
        config.hasPower = false;
        config.hasWater = false;
        
        config.hasGrizzlyBears = false;
        config.hasBlackBears = false;
        config.hasBrownBears = false;
        
        config.openHour = null;
        config.closeHour = null;
        
        
        return config;
    }
    
    private static Metadata.CustomMetadataValue createCustomField(String field, String value) {
        Metadata.CustomMetadataValue cmv = new Metadata.CustomMetadataValue();
        cmv.field = field;
        cmv.value = value;
        return cmv;
    }
    
    private static Metadata.CustomMetadataValue createCustomField(String field, Boolean value) {
        Metadata.CustomMetadataValue cmv = new Metadata.CustomMetadataValue();
        cmv.field = field;
        cmv.value = value;
        return cmv;
    }
    
    private static Metadata.CustomMetadataValue createCustomField(String field, Integer value) {
        Metadata.CustomMetadataValue cmv = new Metadata.CustomMetadataValue();
        cmv.field = field;
        cmv.value = value;
        return cmv;
    }
    
    @RemoteAction  
    public static void configureParkManager(ParkManagerSetupController.ParkConfig config) {
        Metadata.CustomMetadata parkFeatures =  new Metadata.CustomMetadata();
        parkFeatures.fullName = 'Park_Feature.Park_Feature';
        parkFeatures.label = 'Park Feature';
        System.debug(config);
        if(config.campingAllowed) {
            if(config.rvAllowed) {
                parkFeatures.values.add(ParkManagerSetupController.createCustomField('Allows_Recreational_Vehicles__c',Boolean.valueOf('true'))); 
                
                if(config.hasPower) { 
                    parkFeatures.values.add(createCustomField('Has_Power__c',Boolean.valueOf('true'))); 
                }
                
                if(config.hasWater) { 
                    parkFeatures.values.add(createCustomField('Has_Water__c',Boolean.valueOf('true'))); 
                }	 	
            }    
        } 
        
        
        if(config.hasGrizzlyBears) { 
            parkFeatures.values.add(createCustomField('Grizzly_Bear_Present__c',Boolean.valueOf('true'))); 
        }
        
        if(config.hasBlackBears) { 
            parkFeatures.values.add(createCustomField('Black_Bear_Present__c',Boolean.valueOf('true')));           
        }
        
        if(config.hasBrownBears) { 
            parkFeatures.values.add(createCustomField('Brown_Bear_Present__c',Boolean.valueOf('true')));           
        }
        
        if(config.openHour != null) {
            parkFeatures.values.add(createCustomField('Opens_At__c',config.openHour));    
        }
        
        if(config.closeHour != null) {
            parkFeatures.values.add(createCustomField('Closes_At__c',config.closeHour));    
        }
        
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(parkFeatures);
        MyCallback callback = new MyCallback();
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback); 
        System.debug(jobId);
        
    }
    
    
}