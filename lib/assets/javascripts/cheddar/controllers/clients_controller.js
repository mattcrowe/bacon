//index
Cheddar.ClientsController = Ember.ArrayController.extend({

//    clients: function () {
//        var searchTerm = this.get('searchTerm');
//        var clients = this.get('content');
//
//        if (searchTerm) {
//            return clients.filter(function (client) {
//                return client.get('name').toLowerCase().indexOf(searchTerm.toLowerCase()) > -1;
//            });
//        } else {
//            return clients;
//        }
//
//    }.property('content', 'searchTerm')


    clients: function () {
        if (this.get('searchTerm')) {
            clients = this.get('searchedClients');
            if (clients.length == 1) {
                this.transitionToRoute('client', clients[0]);
            }
            return clients;
        } else {
            return this;
        }
    }.property('searchTerm', 'searchedClients'),

    searchedClients: function () {
        var searchTerm = this.get('searchTerm').toLowerCase();
        return this.filter(function (client) {
            return client.get('name').toLowerCase().indexOf(searchTerm) != -1;
        })
    }.property('searchTerm', 'this.@each.name')
});

//new
Cheddar.ClientsNewController = Ember.Controller.extend({

    showUnsavedMessage: function () {
        return this.get('isDirty') && !this.get('isSaving')
    }.property('isDirty', 'isSaving'),

    actions: {
        create: function () {
            var self = this;
            var client = this.store.createRecord('client', this.get('fields'));
            client.save().then(function () {
                self.transitionToRoute('client', client);
            });
        },
        cancel: function () {
            this.transitionToRoute('clients');
        }
    }

});

//show
Cheddar.ClientController = Ember.ObjectController.extend({
    isEditing: false
});

//edit
Cheddar.ClientEditController = Ember.ObjectController.extend({

    showUnsavedMessage: function () {
        return this.get('isDirty') && !this.get('isSaving')
    }.property('isDirty', 'isSaving'),

    actions: {
        save: function () {
            var self = this;
            this.get('model').save().then(function () {
                self.transitionToRoute('client');
            })
        },
        cancel: function () {
            this.get('model').rollback();
            this.transitionToRoute('client');
        },
        delete: function () {
            var self = this;
            this.get('model').destroyRecord().then(function () {
                self.transitionToRoute('clients');
            });
        }
    }
});

