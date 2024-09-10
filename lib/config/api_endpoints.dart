class ApiEndpoints {
  static final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept-Charset': 'UTF-8',
  };
  static const baseUrl = "http://10.0.2.2:8080/api/v1";
  static const authUrl = "$baseUrl/auth";
  static const logout = "$authUrl/logout";

  static const postUrl = "$baseUrl/post";
  static const createPostUrl = "$postUrl/create";
  static const createPostWithoutImageUrl = "$postUrl/createWithoutImage";
  static const likePostUrl = "$postUrl/like-post";
  static const getListsLikePostUrl = "$postUrl/get-lists-like-post";
  static const commentPostUrl = "$postUrl/comment-post";
  static const getListsCommentPostUrl = "$postUrl/get-lists-comment-post";
  static const followUser = "$postUrl/follow";
}
