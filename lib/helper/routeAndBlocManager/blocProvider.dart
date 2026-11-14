import 'package:fassty_resturents_app/auth/login/cubit/login_cubit.dart';
import 'package:fassty_resturents_app/menu/category/cubit/category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import '../../auth/Otp/cubit/otp_cubit.dart';
import '../../auth/signUp/cubit/signup_cubit.dart';
import '../../menu/Item/cubit/item_cubit.dart';
import '../../orders/cubit/ordersList_cubit.dart';


class BlocManager {
  static List<SingleChildWidget> get blocProviders => [
     BlocProvider(create: (context) => SignupCubit()),
     BlocProvider(create: (context) => OtpCubit()),
     BlocProvider(create: (context) => LoginCubit()),
     BlocProvider(create: (context) => CategoryCubit()),
     BlocProvider(create: (context) => ItemCubit()),
    BlocProvider(create: (context) => OrdersListCubit()),





  ];
}
