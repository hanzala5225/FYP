
Map<String, dynamic> searchTagsHandler({
  required String name,
  required String description,
  required String ownerName,

}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
  if(name != ''){
    name.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }
  if(description != ''){
    description.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  if(ownerName != ""){
    ownerName.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  return searchTags;
}



