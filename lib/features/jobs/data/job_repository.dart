import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../domain/job.dart';
import '../domain/job_status.dart';

class JobRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'job_tracker.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE jobs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        company_name TEXT NOT NULL,
        role TEXT NOT NULL,
        status TEXT NOT NULL,
        applied_at TEXT NOT NULL,
        notes TEXT,
        job_url TEXT,
        salary TEXT
      )
    ''');
  }

  Future<int> insertJob(Job job) async {
    final db = await database;
    return await db.insert(
      'jobs',
      job.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Job>> getAllJobs() async {
    final db = await database;
    final maps = await db.query(
      'jobs',
      orderBy: 'applied_at DESC',
    );
    return maps.map((map) => Job.fromMap(map)).toList();
  }

  Future<List<Job>> getJobsByStatus(JobStatus status) async {
    final db = await database;
    final maps = await db.query(
      'jobs',
      where: 'status = ?',
      whereArgs: [status.name],
      orderBy: 'applied_at DESC',
    );
    return maps.map((map) => Job.fromMap(map)).toList();
  }

  Future<int> updateJob(Job job) async {
    final db = await database;
    return await db.update(
      'jobs',
      job.toMap(),
      where: 'id = ?',
      whereArgs: [job.id],
    );
  }

  Future<int> deleteJob(int id) async {
    final db = await database;
    return await db.delete(
      'jobs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
