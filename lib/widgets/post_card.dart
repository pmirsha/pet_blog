import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_blog/models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback? onTap;

  const PostCard({super.key, required this.post, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: post.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => const SizedBox(
                  height: 200,
                  child: Center(child: Icon(Icons.broken_image)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Chip(
                        avatar: const Icon(Icons.pets, size: 16),
                        label: Text('${post.petName} • ${post.petType}'),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(post.title, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text(
                    post.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'by ${post.authorName} • '
                          '${DateFormat.yMMMd().format(post.createdAt)}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      const Icon(Icons.favorite_border, size: 18),
                      const SizedBox(width: 4),
                      Text('${post.likeCount}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
