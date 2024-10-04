import 'package:go_router/go_router.dart';
import 'package:login_and_registration/app/router/route_path.dart';
import 'package:login_and_registration/app/router/routes.dart';
import 'package:login_and_registration/data/init/init_service.dart';

final routerConfig = GoRouter(
  routes: $appRoutes,
  initialLocation: RoutePath.splash,
  errorBuilder: (c, s) => ErrorRoute(error: s.error!).build(c, s),
  observers: [
    logger.setRouteObserver(),
  ],
);
