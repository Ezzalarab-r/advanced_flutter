import '../constants.dart';
import '../failures/error_handler.dart';
import '../responses/responses.dart';

abstract class LocalDS {
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDSImpl implements LocalDS {
  // Run Time Cache
  Map<String, CachedItem> cacheData = <String, CachedItem>{};
  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheData[DataConstants.cacheHomeKey];
    if (cachedItem != null &&
        cachedItem.isValid(DataConstants.cachHomeInterval)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(ResponseCode.cacheError);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheData[DataConstants.cacheHomeKey] = CachedItem(homeResponse);
  }

  @override
  void clearCache() => cacheData.clear();

  @override
  void removeFromCache(String key) => cacheData.remove(key);
}

class CachedItem {
  final dynamic data;
  int cacheTimeInMilliSec = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expireTimeInSec) {
    int expireTimeInMilliSec = expireTimeInSec * 1000;
    int currentTimeInMilliSec = DateTime.now().millisecondsSinceEpoch;
    return currentTimeInMilliSec - cacheTimeInMilliSec < expireTimeInMilliSec;
  }
}
