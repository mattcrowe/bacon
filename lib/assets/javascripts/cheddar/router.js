Cheddar.Router.map(function () {
    this.resource('home', function () {
        this.resource('clients', function(){
            this.route('show', { path: '/:client_id' });
            this.route('edit', { path: '/:client_id/edit' });
        });
        this.resource('client', { path: '/client/:client_id' }, function(){
            this.route('edit');
        });
        this.resource('projects');
//        this.resource('projects', function () {
//            this.resource('project', { path: ':project_id' });
//        });
    });
});