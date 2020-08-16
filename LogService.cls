public class LogService implements Callable {

    public class Definition {
        
        String Tag = 'Examples';
        String Label = 'Log Service';
        String Description = 'Sends an email containing the event parameters.';
        String Icon = 'lightning';
        Integer Chunks = 5;
        Map<String, String> StepConfig = new Map<String, String>{
            'address' => 'String'
        };

    }



    // execute
    public Object call(String m, Map<String, Object> event) {
        
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setSubject('[Log] ' + UserInfo.getOrganizationName());
        message.setPlainTextBody(Json.serializePretty(event));
        message.setToAddresses(new List<String>{
            (String)event.get('address')
        });

        return new List<Object>{
            event, message
        };
    }

}