import 'package:dio/dio.dart';
import 'package:movie_app/widgets/loader.dart';

import '../widgets/dialog.dart';

class Api {
  Appdialog dialog = locator<Appdialog>();
  late Dio dio;
  static Api sharedInstence = Api();
  Api() {
    final option = BaseOptions(baseUrl: 'https://api.themoviedb.org');
    dio = Dio(option);
  }
  Future<Response?> getMovieList(int pageCount) async {
    try {
      final response = await dio.get(
        '/3/movie/top_rated',
        queryParameters: {
          'api_key': 'f6a7fd2ad2e174eb8aada2b4fc11a8e4',
          'language': 'en-US',
          'page': pageCount,
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      }
    } on DioError catch (e) {
      dialog.alertDialog(e.response!.data['status_message']);
      print(e.response!.data['status_message']);
    } finally {
      Loader.hideLoading();
    }
    return null;
  }
}
