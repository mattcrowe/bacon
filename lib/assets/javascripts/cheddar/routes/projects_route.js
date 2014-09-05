Cheddar.ProjectsRoute = Ember.Route.extend({
    model: function () {
        return $.getJSON('/api/projects').then(function (data) {
            return data.projects.map(function (projects) {
                return projects;
            })
        });
    }
});