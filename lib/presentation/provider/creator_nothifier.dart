import 'package:flutter/cupertino.dart';

import '../../common/helper_local.dart';
import '../../common/requeststate.dart';
import '../../domain/enities/creator.dart';
import '../../domain/enities/product_media_image.dart';
import '../../domain/user_case/get_creator.dart';
import '../../domain/user_case/get_creator_collection.dart';

class CreatorNothifier extends ChangeNotifier {
  final HelperLocal helperLocal;
  final GetCreator getCreator;
  final GetCreatorCollection getCreatorCollection;

  CreatorNothifier(
      this.helperLocal, this.getCreator, this.getCreatorCollection);

  RequestState _nowCreatorState = RequestState.empty;
  RequestState get nowCreaotrState => _nowCreatorState;

  RequestState _nowCreatorStateImage = RequestState.empty;
  RequestState get nowCreaotrStateImage => _nowCreatorStateImage;

  String _imageProifle = "";
  String get imageProfile => _imageProifle;

  String _message = "";
  String get message => _message;

  final List<int> _follow = [];
  List<int> get follow => _follow;

  late Creator _creator;
  Creator get creator => _creator;

   List<ProductMediaImage> _image=[] ;
  List<ProductMediaImage> get image => _image;

  void init() async {
    _imageProifle = await helperLocal.loadProfileImage() ?? "";
    _nowCreatorState = RequestState.loading;
    notifyListeners();
  }

  Future<void> fechdata(String id) async {
    final result = await getCreator.execute(id);
    result.fold((l) {
      _message = l.message;
      _nowCreatorState = RequestState.error;
      notifyListeners();
    }, (r) {
      _creator = r;
      _nowCreatorState = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> fechdataImage(String id) async {
    final result = await getCreatorCollection.execute(id);
    result.fold((l) {
      _message = l.message;
      _nowCreatorStateImage = RequestState.error;
      notifyListeners();
    }, (r) {
      _image = r;
      _nowCreatorStateImage = RequestState.loaded;
      notifyListeners();
    });
  }

  void followUnfollow(int id) {
   if(_follow.contains(id)){
    _follow.remove(id);
   }else{
    _follow.add(id);
   }
    notifyListeners();
  }
}
