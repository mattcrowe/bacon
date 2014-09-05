Cheddar.ClientsRoute = Ember.Route.extend({
    model: function () {
        return $.getJSON('/api/clients').then(function (data) {
            return data.clients.map(function (clients) {
                return clients;
            })
        });
    }
});

Cheddar.ClientRoute = Ember.Route.extend({
    model: function(params) {
        return $.getJSON('/api/clients/' + params.client_id).then(function (data) {
            return data.client;
        });
    }
});

Cheddar.ClientEditRoute = Ember.Route.extend({
    model: function(){
        return this.modelFor('client');
    }
});