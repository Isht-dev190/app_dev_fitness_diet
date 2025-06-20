import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/article_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/features/Tips/tips_viewModel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// This widget just shows the details of an article
class ArticleDetailsView extends StatelessWidget {
  final Article article;

  // Just the constructor, takes an article and that's it.
  const ArticleDetailsView({
    super.key,
    required this.article,
  });

  // Builds the whole article details screen, with an app bar and all the info
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // The app bar at the top, with a gradient and some buttons
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPallete.primaryColor.withOpacity(0.8),
                      AppPallete.primaryColor,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        article.title,
                        style: const TextStyle(
                          color: AppPallete.textColorDarkMode,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        article.date,
                        style: const TextStyle(
                          color: AppPallete.textColorDarkMode,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppPallete.textColorDarkMode),
              onPressed: () => context.pop(),
            ),
            actions: [
              // Like button, toggles the heart icon
              Consumer<TipsViewModel>(
                builder: (context, viewModel, child) {
                  return IconButton(
                    icon: Icon(
                      article.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: AppPallete.textColorDarkMode,
                    ),
                    onPressed: () {
                      viewModel.toggleLike(article.id);
                    },
                  );
                },
              ),
            ],
          ),
          // The rest of the article, just a bunch of text and  some content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(article.category),
                    backgroundColor: AppPallete.primaryColor.withOpacity(0.1),
                    labelStyle: const TextStyle(color: AppPallete.primaryColor),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppPallete.textColorDarkMode,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (article.content != null) ...[
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      article.content!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppPallete.textColorDarkMode,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 