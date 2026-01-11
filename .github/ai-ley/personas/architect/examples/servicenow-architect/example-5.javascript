// Incident Management Business Rule Example
(function executeRule(current, previous /*null when async*/) {
    // Auto-assignment logic based on category and assignment group
    if (current.category == 'software' && current.assignment_group.isNil()) {
        var gr = new GlideRecord('sys_user_group');
        gr.addQuery('name', 'Software Support');
        gr.query();
        if (gr.next()) {
            current.assignment_group = gr.sys_id;
            
            // Auto-assign to available group member
            var memberGr = new GlideRecord('sys_user_grmember');
            memberGr.addQuery('group', gr.sys_id);
            memberGr.addQuery('user.active', true);
            memberGr.query();
            if (memberGr.next()) {
                current.assigned_to = memberGr.user;
            }
        }
    }
    
    // SLA calculation and escalation
    if (current.priority == '1' && current.state == 'New') {
        // High priority incident - set escalation timer
        var sla = new GlideRecord('task_sla');
        sla.initialize();
        sla.task = current.sys_id;
        sla.sla = 'Critical Incident Response';
        sla.start_time = new GlideDateTime();
        sla.insert();
    }
    
    // Knowledge base article suggestion
    if (current.short_description.changes()) {
        var kb = new KnowledgeBase();
        var suggestions = kb.getSuggestions(current.short_description);
        if (suggestions.length > 0) {
            current.work_notes = 'Suggested KB articles: ' + suggestions.join(', ');
        }
    }
})(current, previous);