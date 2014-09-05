Cheddar.ClientsRoute = Ember.Route.extend({

    model: function() { return this.store.find('client') }

//    model: function () {
//        return $.getJSON('/api/v1/clients').then(function (data) {
//            return data.clients.map(function (clients) {
//                return clients;
//            })
//        });
//    }
});

Cheddar.ClientRoute = Ember.Route.extend({

    model: function(params) { return this.store.find('client', params.id) }
    ,

    renderTemplate: function() {
        this.render({ outlet: 'sidebar' });
    }

//    model: function(params) {
//        return $.getJSON('/api/v1/clients/' + params.client_id).then(function (data) {
//            return data.client;
//        });
//    }
});

Cheddar.ClientEditRoute = Ember.Route.extend({

    activate:   function() { console.log('act');this.controllerFor('client').set('isEditing', true) },
    deactivate: function() { this.controllerFor('client').set('isEditing', false) },

    model: function(){
        return this.modelFor('client');
    }
});