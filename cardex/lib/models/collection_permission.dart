
enum CollectionPermission {
  readOnly,
  readWrite,
  admin,
  systemDefault,
  editable, // Added for backward compatibility with mock data
}

extension CollectionPermissionExtension on CollectionPermission {
  bool get canEdit => this == CollectionPermission.readWrite || 
                     this == CollectionPermission.admin || 
                     this == CollectionPermission.editable;
  
  bool get canDelete => this == CollectionPermission.admin;
  
  bool get canShare => this == CollectionPermission.readWrite || 
                      this == CollectionPermission.admin;
}
