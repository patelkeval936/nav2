class BookRoutePath {
  int? id;
  bool isError = false;

  BookRoutePath.showError(){
    isError = true;
    id = null;
  }

  BookRoutePath.home() {
    isError = false;
    id = null;
  }

  BookRoutePath.detail(provideId){
    isError = false;
    id = provideId;
  }

  bool get isShowError => isError;

  bool get isHomePage => id == null && isError == false;

  bool get isDetailPage => id != null && isError == false;

}