db.artists.createIndex({mbid: 1}, {background: true});
db.artists.createIndex({fullName: 1}, {background: true});
db.artists.createIndex({aliases: 1}, {background: true});
db.artists.createIndex({fullName:'text', aliases:'text'}, {background: true});
db.products.createIndex({productId:1}, {background: true});
db.products.createIndex({upcCode:1}, {background: true});
db.products.createIndex({tracks:1}, {background: true});
