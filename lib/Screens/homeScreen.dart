import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/weatherProvider.dart';
import '../widgets/WeatherInfo.dart';

import '../widgets/hourlyForecast.dart';
import '../widgets/locationError.dart';
import '../widgets/mainWeather.dart';
import '../widgets/requestError.dart';
import '../widgets/searchBar.dart';
import '../widgets/weatherDetail.dart';
import '../widgets/sevenDayForecast.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> _getData() async {
    _isLoading = true;
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData();
    _isLoading = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false).getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final myContext = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: myContext.primaryColor,
                ),
              )
            : weatherData.loading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: myContext.primaryColor,
                    ),
                  )
                : weatherData.isLocationError
                    ? LocationError()
                    : Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('https://img.freepik.com/free-vector/white-abstract-background-3d-paper-style_23-2148403778.jpg?w=2000'),
                fit: BoxFit.cover

            ),
          ),

                      child: Column(
                          children: [

                            SearchBar(),
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: 2,
                              effect: ExpandingDotsEffect(
                                activeDotColor: myContext.primaryColor,
                                dotHeight: 6,
                                dotWidth: 6,
                              ),
                            ),
                            weatherData.isRequestError
                                ? RequestError()
                                : Expanded(
                                    child: PageView(
                                      controller: _pageController,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: mediaQuery.size.width,
                                          child: RefreshIndicator(
                                            onRefresh: () =>
                                                _refreshData(context),
                                            backgroundColor: Colors.black54,
                                            child: ListView(
                                              children: [
                                                MainWeather(wData: weatherData),
                                                WeatherInfo(
                                                    wData: weatherData
                                                        .currentWeather),
                                                HourlyForecast(
                                                    weatherData.hourlyWeather),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: mediaQuery.size.height,
                                          width: mediaQuery.size.width,
                                          child: ListView(
                                            children: [
                                              SevenDayForecast(
                                                wData: weatherData,
                                                dWeather:
                                                    weatherData.sevenDayWeather,
                                                // weatherData.sevenDayWeather.toString(),
                                              ),
                                              WeatherDetail(wData: weatherData),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                    ),
      ),
    );
  }
}
