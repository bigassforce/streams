@IsTest class LogServiceTest {

    @IsTest static void testServiceResults() {
    
        // arrange
        Map<String, Object> event = new Map<String, Object>{
            'address' => 'test@host'
        };

        // act
        List<Object> outputs = (List<Object>)new LogService().call('execute', event);

        // assert
        System.assert(outputs[1] instanceof Messaging.Email);

        // cover definition
        new LogService.Definition();

    }

}