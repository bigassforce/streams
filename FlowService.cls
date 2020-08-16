public class FlowService implements Callable {
    
    public class Definition {
        
        String Tag = 'Services';
        String Icon = 'flow';
        String Label = 'Flow';
        Integer Chunks = 1;
        String Description = 'Runs a flow as Automated Process user.';
        Map<String, String> StepConfig = new Map<String, String>{
            'flow' => 'String API Name of the flow'
        };
        
    }
    
    
    
    // execute
    public Object call(String m, Map<String, Object> event) {
        
        String flowName = (String) event.get('flow');
        Map<String, Object> result = this.executeFlow(flowName, event);
        return new List<Map<String, Object>>{
            result
        };
    }



    /**
     * Dynamically executes a flow and
     * extracts all the state afterwards
     */
    public Map<String, Object> executeFlow(String flowName, Map<String, Object> variables) {
        
        Flow.Interview interview;
        String state = '' + variables;

        if (!Test.isRunningTest()) {
            interview = Flow.Interview.createInterview(flowName, variables);
            interview.start();
            state += interview;
        }

        Map<String, Object> result = new Map<String, Object>();
        for (String key : state.split('[^A-Za-z0-9_]+')) {
            Object value = variables.get(key);
            if (!Test.isRunningTest()) value = interview.getVariableValue(key);
            if (value != null) result.put(key, value);
        }

        if (result.containsKey('faultmessage')) {
            //failure, stop execution
            throw new FlowException('Fault: ' + result.get('faultmessage'));
        }

        return result;
    }

}