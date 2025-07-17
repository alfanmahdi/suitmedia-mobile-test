import 'package:flutter/material.dart';
import 'package:suitmedia_test/models/user_model.dart';
import 'package:suitmedia_test/services/api_service.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final List<User> _users = [];
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchUsers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchUsers({bool isRefresh = false}) async {
    if (_isLoading || (!isRefresh && !_hasMore)) return;

    setState(() {
      _isLoading = true;
    });

    if (isRefresh) {
      _currentPage = 1;
      _users.clear();
      _hasMore = true;
    }

    try {
      final newUsers = await fetchUsers(page: _currentPage);

      setState(() {
        if (newUsers.isNotEmpty) {
          _users.addAll(newUsers);
          _currentPage++;
        } else {
          _hasMore = false;
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error fetching users: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Third Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => _fetchUsers(isRefresh: true),
        child: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList() {
    if (_users.isEmpty && !_isLoading) {
      return const Center(
        child: Text("Tidak ada data pengguna.", style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _users.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _users.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final user = _users[index];
        return Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context, user);
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.avatar),
                radius: 30,
              ),
              title: Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(user.email),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.0),
              child: Divider(),
            ),
          ],
        );
      },
    );
  }
}
