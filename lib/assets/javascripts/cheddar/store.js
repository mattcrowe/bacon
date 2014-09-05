//#Cheddar.ApplicationSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin,
//#  attrs:
//#  {
//#    images: { embedded: 'always' }
//#    variants: { embedded: 'always' }
//#  }
//#
//#  extractArray: (store, type, payload) ->
//#    delete payload.count
//#    delete payload.pages
//#    delete payload.per_page
//#    delete payload.total_count
//#    delete payload.current_page
//#
//#    @_super(store, type, payload)
//#)
//#
//#Cheddar.Store = DS.Store.extend
//#  adapter: DS.RESTAdapter.extend
//#    namespace: 'api'

//Cheddar.ApplicationAdapter = DS.LSAdapter;

Cheddar.ApplicationAdapter = DS.RESTAdapter.extend({
    host: '/api'
});