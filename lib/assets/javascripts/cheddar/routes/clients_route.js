Cheddar.ClientsRoute = Ember.Route.extend({
    model: function () {
        return this.store.find('client')
    },
    renderTemplate: function () {
        this.render('clients.index');
    }
});

Cheddar.ClientsNewRoute = Ember.Route.extend({
    setupController: function (controller) {
        controller.set('fields', {})
    }
});

Cheddar.ClientRoute = Ember.Route.extend({
    model: function (params) {
        model = this.store.find('client', params.id);
//        console.log(111);
//        console.log(model.name);
//        console.log(model);
        return model;
    },
    renderTemplate: function () {
        this.render('clients.show');
    }
});

Cheddar.ClientEditRoute = Ember.Route.extend({
    model: function () {
        return this.modelFor('client')
    },
    renderTemplate: function () {
        this.render('clients.edit');
    },
    activate: function () {
        this.controllerFor('client').set('isEditing', true)
    },
    deactivate: function () {
        this.controllerFor('client').set('isEditing', false)
    }
});

