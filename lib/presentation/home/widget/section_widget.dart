import 'package:flutter/material.dart';
import 'package:moviedb/common/widget/image_view.dart';
import 'package:moviedb/config/constanta.dart';
import 'package:moviedb/data/models/movie/movie_model.dart';
import 'package:moviedb/theme/app_color.dart';
import 'package:moviedb/theme/app_font.dart';
import 'package:shimmer/shimmer.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final List<MovieModel> data;
  final Function(MovieModel) onItemClick;
  final Function onClickMore;

  const SectionWidget({
    super.key,
    required this.title,
    required this.data,
    required this.onItemClick,
    required this.onClickMore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Text(title, style: textLarge),
            ),
            InkWell(
              onTap: () {
                onClickMore();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  children: [
                    Text('See More', style: textRegular),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColor.white,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        if (data.isEmpty)
          const MovieShimmer()
        else
          SizedBox(
            height: 210,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  width: 150,
                  child: InkWell(
                    onTap: () {
                      onItemClick(data[index]);
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Hero(
                        tag: '$title${data[index].title}',
                        child: ImageView(
                          url: '$imageUrl${data[index].posterPath}',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class MovieShimmer extends StatelessWidget {
  const MovieShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Shimmer.fromColors(
        baseColor: AppColor.darkBlue,
        highlightColor: AppColor.lightBlue,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            children: [
              Container(
                width: 150,
                height: 210,
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    color: AppColor.darkBlue,
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 210,
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    color: AppColor.darkBlue,
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 210,
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    color: AppColor.darkBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
