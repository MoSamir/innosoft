class URL {
  static String getRetrieveUsers(int pageSize, int pageNumber) =>
      "https://reqres.in/api/users?per_page=$pageSize&page=$pageNumber";
}
