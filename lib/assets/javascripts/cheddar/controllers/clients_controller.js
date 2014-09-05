Cheddar.ClientsShowController = Ember.ObjectController.extend({

    isEditing: false,

    actions: {
        edit: function(){
            console.log(111);
//            this.set('isEditing', true);
            this.transitionToRoute('clients.edit');
        },
        save: function () {
            this.set('isEditing', false);

            var client = this.get('model');
            // this will tell Ember-Data to save/persist the new record

            client = this.store.push('client', client);

            result = client.save();



            // then transition to the current client
            this.transitionToRoute('client', client);
        }
    }
});



Cheddar.ClientController = Ember.ObjectController.extend({

    isEditing: false,

    actions: {
        edit: function(){
            this.set('isEditing', true);
            this.transitionToRoute('client.edit');
        },
        save: function () {

            var client = this.get('model');
            // this will tell Ember-Data to save/persist the new record

            client = this.store.push('client', client);

            result = client.save();

            this.set('isEditing', false);

            // then transition to the current client
            this.transitionToRoute('client', client);
        }
    }
});



Cheddar.ClientEditController = Cheddar.ClientController.extend({
    actions: {
        save: function () {

            var client = this.get('model');
            // this will tell Ember-Data to save/persist the new record

            client = this.store.push('client', client);

            result = client.save();

            this.set('isEditing', false);

            // then transition to the current client
            this.transitionToRoute('client', client);
        }
    }
});