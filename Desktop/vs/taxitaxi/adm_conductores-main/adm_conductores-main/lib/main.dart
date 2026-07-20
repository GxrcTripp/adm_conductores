import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para kIsWeb

void main() {
  runApp(const TaxiAdminApp());
}

class TaxiAdminApp extends StatelessWidget {
  const TaxiAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Administración de Taxis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade800,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MainAdminScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({super.key});

  @override
  State<MainAdminScreen> createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    'Panel de Control',
    'Gestión de Conductores',
    'Flota de Vehículos',
    'Reportes Financieros',
    'Configuración'
  ];

final List<Widget> _screens = [
  const DashboardView(),
  const ConductoresGestionView(),
  const VehiculosGestionView(),
  const ReportesFinancierosView(),
  const ConfiguracionView(), // <-- Aquí la nueva integración
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex], style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 1,
        surfaceTintColor: Colors.white,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                    child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 8), textAlign: TextAlign.center,),
                  ),
                )
              ],
            ), 
            onPressed: () {}
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(radius: 18, backgroundColor: Colors.blueGrey, child: Text('AD', style: TextStyle(color: Colors.white, fontSize: 12)),),
          ),
          const Center(child: Text("Admin User  ")),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 600)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: Text('Dashboard')),
                NavigationRailDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: Text('Conductores')),
                NavigationRailDestination(icon: Icon(Icons.local_taxi_outlined), selectedIcon: Icon(Icons.local_taxi), label: Text('Vehículos')),
                NavigationRailDestination(icon: Icon(Icons.insert_chart_outlined), selectedIcon: Icon(Icons.insert_chart), label: Text('Reportes')),
                NavigationRailDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: Text('Config')),
              ],
            ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Container(
              color: Colors.grey.shade100,
              child: _screens[_selectedIndex],
            ),
          ),
        ],
      ),
      drawer: MediaQuery.of(context).size.width <= 600 ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Text('AD', style: TextStyle(fontSize: 24))),
                  SizedBox(height: 10),
                  Text('Admin Taxi', style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text('admin@flota.com', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            ListTile(leading: const Icon(Icons.dashboard), title: const Text('Dashboard'), selected: _selectedIndex == 0, onTap: () { setState(() {_selectedIndex=0;}); Navigator.pop(context); },),
            ListTile(leading: const Icon(Icons.people), title: const Text('Conductores'), selected: _selectedIndex == 1, onTap: () { setState(() {_selectedIndex=1;}); Navigator.pop(context); },),
          ],
        ),
      ) : null,
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Bienvenido de nuevo, Administrador", style: TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 20),
          LayoutBuilder(builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 1000 ? 4 : 2;
            return GridView.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3,
              children: [
                _statCard("Conductores Totales", "145", Icons.people, Colors.blue),
                _statCard("Viajes Hoy", "1,284", Icons.trending_up, Colors.green),
                _statCard("Recaudación Hoy", "\$4,850", Icons.attach_money, Colors.orange),
                _statCard("Vehículos en Taller", "3", Icons.handyman, Colors.red),
              ],
            );
          }),
          const SizedBox(height: 30),
          const Text("Monitoreo de Flota", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 80, color: Colors.grey),
                    Text("Aquí iría la integración de Google Maps/Mapbox", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ConductoresGestionView extends StatefulWidget {
  const ConductoresGestionView({super.key});

  @override
  State<ConductoresGestionView> createState() => _ConductoresGestionViewState();
}

class _ConductoresGestionViewState extends State<ConductoresGestionView> {
  final List<Map<String, dynamic>> conductores = [
    {'id': 1, 'nombre': 'Carlos Ruiz', 'estado': 'Activo', 'taxi': 'TX-102', 'calificacion': 4.8, 'viajes': 320},
    {'id': 2, 'nombre': 'María Santos', 'estado': 'Activo', 'taxi': 'TX-055', 'calificacion': 4.9, 'viajes': 451},
    {'id': 3, 'nombre': 'Pedro Gómez', 'estado': 'En Viaje', 'taxi': 'TX-089', 'calificacion': 4.7, 'viajes': 298},
    {'id': 4, 'nombre': 'Laura Díaz', 'estado': 'Inactivo', 'taxi': 'TX-112', 'calificacion': 4.5, 'viajes': 150},
    {'id': 5, 'nombre': 'Javier Morales', 'estado': 'Suspendido', 'taxi': 'TX-012', 'calificacion': 3.8, 'viajes': 88},
    {'id': 6, 'nombre': 'Sofía Herrera', 'estado': 'Activo', 'taxi': 'TX-120', 'calificacion': 5.0, 'viajes': 112},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar por nombre, ID o taxi...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.zero
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () => _mostrarFormularioConductor(context), 
                icon: const Icon(Icons.add),
                label: const Text('Nuevo Conductor'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Conductor')),
                    DataColumn(label: Text('Estado')),
                    DataColumn(label: Text('Taxi Asignado')),
                    DataColumn(label: Text('Calificación')),
                    DataColumn(label: Text('Viajes')),
                    DataColumn(label: Text('Acciones')),
                  ],
                  rows: conductores.map((c) {
                    return DataRow(cells: [
                      DataCell(Row(children: [CircleAvatar(radius: 12, child: Text(c['nombre'][0])), SizedBox(width: 8), Text(c['nombre'])])),
                      DataCell(_getEstadoChip(c['estado'])),
                      DataCell(Text(c['taxi'])),
                      DataCell(Text(c['calificacion'].toString())),
                      DataCell(Text(c['viajes'].toString())),
                      DataCell(Row(children: [
                        IconButton(icon: Icon(Icons.edit, size: 18), onPressed: () => _mostrarFormularioConductor(context, c)),
                        IconButton(icon: Icon(Icons.delete, size: 18, color: Colors.red), onPressed: () => _confirmarEliminar(context, c['nombre'])),
                      ])),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text("Filas por página: 10")]),
          ),
        ],
      ),
    );
  }

  Widget _getEstadoChip(String estado) {
    Color color = (estado == 'Activo') ? Colors.green : Colors.orange;
    return Chip(label: Text(estado), backgroundColor: color.withOpacity(0.2));
  }

  void _mostrarFormularioConductor(BuildContext context, [Map<String, dynamic>? conductor]) {
    showDialog(context: context, builder: (context) => AlertDialog(title: Text("Gestionar Conductor")));
  }

  void _confirmarEliminar(BuildContext context, String nombre) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Eliminando a $nombre")));
  }
}
class VehiculosGestionView extends StatefulWidget {
  const VehiculosGestionView({super.key});

  @override
  State<VehiculosGestionView> createState() => _VehiculosGestionViewState();
}

class _VehiculosGestionViewState extends State<VehiculosGestionView> {
  final List<Map<String, dynamic>> vehiculos = [
    {'id': 1, 'placa': 'TX-102', 'modelo': 'Toyota Corolla', 'estado': 'Disponible', 'km': 120500},
    {'id': 2, 'placa': 'TX-055', 'modelo': 'Hyundai Accent', 'estado': 'En Servicio', 'km': 85200},
    {'id': 3, 'placa': 'TX-089', 'modelo': 'Kia Rio', 'estado': 'Disponible', 'km': 45300},
    {'id': 4, 'placa': 'TX-112', 'modelo': 'Toyota Corolla', 'estado': 'Mantenimiento', 'km': 156000},
    {'id': 5, 'placa': 'TX-012', 'modelo': 'Chevrolet Aveo', 'estado': 'Disponible', 'km': 210000},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar por placa, modelo o estado...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.zero
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {}, 
                icon: const Icon(Icons.add),
                label: const Text('Nuevo Vehículo'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Placa')),
                    DataColumn(label: Text('Modelo')),
                    DataColumn(label: Text('Estado')),
                    DataColumn(label: Text('Kilometraje')),
                    DataColumn(label: Text('Acciones')),
                  ],
                  rows: vehiculos.map((v) {
                    return DataRow(cells: [
                      DataCell(Text(v['placa'], style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text(v['modelo'])),
                      DataCell(_getEstadoChip(v['estado'])),
                      DataCell(Text(v['km'].toString())),
                      DataCell(Row(children: [
                        IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}),
                        IconButton(icon: const Icon(Icons.delete, size: 18, color: Colors.red), onPressed: () {}),
                      ])),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEstadoChip(String estado) {
    Color color = (estado == 'Disponible') ? Colors.green : (estado == 'En Servicio' ? Colors.blue : Colors.red);
    return Chip(label: Text(estado), backgroundColor: color.withOpacity(0.2));
  }
}
class ReportesFinancierosView extends StatelessWidget {
  const ReportesFinancierosView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Reporte Diario"),
              Tab(text: "Reporte Mensual"),
              Tab(text: "Reporte Anual"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildReporteTab(context, "Diario"),
                _buildReporteTab(context, "Mensual"),
                _buildReporteTab(context, "Anual"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReporteTab(BuildContext context, String tipo) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Tarjetas de KPIs
          Row(
            children: [
              _kpiCard("Total Ingresos", "\$1,250", Icons.attach_money, Colors.green),
              const SizedBox(width: 16),
              _kpiCard("Comisiones Choferes", "\$375", Icons.percent, Colors.blue),
              const SizedBox(width: 16),
              _kpiCard("Servicios Realizados", "42", Icons.local_taxi, Colors.orange),
            ],
          ),
          const SizedBox(height: 24),
          // Tabla de detalles
          Card(
            child: Column(
              children: [
                ListTile(title: Text("Detalle Operativo - $tipo"), trailing: IconButton(icon: const Icon(Icons.download), onPressed: () {})),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Fecha')),
                    DataColumn(label: Text('Concepto')),
                    DataColumn(label: Text('Monto')),
                    DataColumn(label: Text('Comisión Driver')),
                  ],
                  rows: [
                    DataRow(cells: [
                      const DataCell(Text("19/07/2026")),
                      const DataCell(Text("Servicio App")),
                      const DataCell(Text("\$50.00")),
                      const DataCell(Text("\$15.00", style: TextStyle(color: Colors.red))),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kpiCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 12)),
              Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
class ConfiguracionView extends StatelessWidget {
  const ConfiguracionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Configuración del Sistema", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          // Usamos LayoutBuilder para que sea responsivo como tu Dashboard
          LayoutBuilder(builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 900 ? 3 : 2;
            return GridView.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.5, // Ajusta la altura de las tarjetas
              children: [
                _configCard(context, "Parámetros Operativos", Icons.tune, Colors.blue),
                _configCard(context, "Gestión de Usuarios", Icons.admin_panel_settings, Colors.purple),
                _configCard(context, "Notificaciones", Icons.notifications_active, Colors.orange),
                _configCard(context, "Integraciones API", Icons.api, Colors.teal),
                _configCard(context, "Mantenimiento", Icons.build, Colors.red),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _configCard(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _openConfigModal(context, title),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(title, 
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Al hacer clic, abrimos un diálogo limpio (modal) para editar
  void _openConfigModal(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Configurar: $title"),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextField(decoration: InputDecoration(labelText: "Valor 1")),
              const SizedBox(height: 10),
              const TextField(decoration: InputDecoration(labelText: "Valor 2")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cerrar")),
          ElevatedButton(onPressed: () {}, child: const Text("Guardar")),
        ],
      ),
    );
  }
}
}
