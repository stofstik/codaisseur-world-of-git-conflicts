Valley.delete_all
Dinosaur.delete_all

ordesa = Valley.create(name: "Ordesa Valley")
waipi = Valley.create(name: "Waipi'o Valley")
geyser_valley = Valley.create(name: "The Valley of Geysers")

Dinosaur.create!( { name: "Iguanodon", age: 3, image_url: "http://images.dinosaurpictures.org.rsz.io/iguanodon_b35b.jpg", valley: geyser_valley } )
Dinosaur.create!( { name: "Mosasaurus", age: 10, image_url: "http://images.dinosaurpictures.org.rsz.io/mosasaurus_hoffmani_by_olorotitan-d4esmfm_5c48.jpg", valley: waipi } )
Dinosaur.create!( { name: "Hungarosaurus", age: 15, image_url: "http://images.dinosaurpictures.org.rsz.io/nyito_4f23.jpg", valley: ordesa } )

