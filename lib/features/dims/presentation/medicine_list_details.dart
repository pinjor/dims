import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/dims/presentation/medicine_list.dart';
import 'package:flutter/material.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final Medicine medicine;

  const MedicineDetailsScreen({super.key, required this.medicine});

  @override
  _MedicineDetailsScreenState createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  String? _expandedSection; // Track which section is currently expanded

  void _toggleSection(String section) {
    setState(() {
      if (_expandedSection == section) {
        // If clicking the already expanded section, collapse it
        _expandedSection = null;
      } else {
        // Expand the new section
        _expandedSection = section;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medicine.brandName),
        backgroundColor: appColors.themeColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medicine Header
            _buildMedicineHeader(),
            const SizedBox(height: 16),

            // Price Section
            _buildPriceSection(),
            const SizedBox(height: 16),

            // Expandable Sections
            _buildExpandableSection('Indications', _buildIndicationsSection()),
            _buildExpandableSection('Dosage', _buildDosageSection()),
            _buildExpandableSection('Administration', _buildAdministrationSection()),
            _buildExpandableSection('Contraindications', _buildContraindicationsSection()),
            _buildExpandableSection('Side Effects', _buildSideEffectsSection()),
            _buildExpandableSection('Precautions & Warnings', _buildPrecautionsSection()),
            _buildExpandableSection('Pregnancy & Lactation', _buildPregnancySection()),
            _buildExpandableSection('Therapeutic Class', _buildTherapeuticClassSection()),
            _buildExpandableSection('Mode of Action', _buildModeOfActionSection()),
            _buildExpandableSection('Interaction', _buildInteractionSection()),
            _buildExpandableSection('Pack Size & Price', _buildPackSizePriceSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.medicine.brandName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '${widget.medicine.genericName} ${widget.medicine.dosage}',
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          'By ${widget.medicine.company}',
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                widget.medicine.pactType,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Unit Price:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '80.00 BDT',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: appColors.themeColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(String title, Widget content) {
    bool isExpanded = _expandedSection == title;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          isExpanded ? Icons.expand_less : Icons.expand_more,
          color: appColors.themeColor,
        ),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) {
          _toggleSection(title);
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicationsSection() {
    return const Text(
      'Naproxen is indicated for the relief of pain and inflammation in conditions such as:\n'
          '- Rheumatoid arthritis\n'
          '- Osteoarthritis\n'
          '- Ankylosing spondylitis\n'
          '- Tendinitis\n'
          '- Bursitis\n'
          '- Acute gout\n'
          '- Menstrual cramps\n'
          '- Mild to moderate pain',
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildDosageSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adult dose:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Apply a thin film of the gel to the affected area 3-4 times daily, or as directed by a physician.'),
        SizedBox(height: 8),
        Text(
          'Child dose:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Not recommended for children under 12 years of age without medical supervision.'),
        SizedBox(height: 8),
        Text(
          'Renal dose:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Dosage adjustment may be necessary in patients with renal impairment. Consult a physician.'),
      ],
    );
  }

  Widget _buildAdministrationSection() {
    return const Text(
      'For external use only. Clean and dry the affected area before application. '
          'Apply a thin layer of the gel and gently rub it in. Wash hands after application, '
          'unless the hands are the area being treated. Do not apply to broken or irritated skin. '
          'Avoid contact with eyes, mucous membranes, and open wounds.',
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildContraindicationsSection() {
    return const Text(
      'Hypersensitivity to naproxen, aspirin, other NSAIDs, or any component of the formulation. '
          'Patients who have experienced asthma, urticaria, or allergic-type reactions after taking '
          'aspirin or other NSAIDs. Use in the setting of coronary artery bypass graft (CABG) surgery.',
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildSideEffectsSection() {
    return const Text(
      'Common side effects may include:\n'
          '- Skin irritation at application site\n'
          '- Redness\n'
          '- Itching\n'
          '- Dryness\n'
          '\nLess common side effects:\n'
          '- Rash\n'
          '- Photosensitivity\n'
          '- Systemic effects (with excessive use) such as gastrointestinal discomfort',
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildPrecautionsSection() {
    return const Text(
      'For external use only. Do not apply to broken or damaged skin. '
          'Avoid exposure to sunlight or artificial UV rays during treatment and for 2 weeks after '
          'discontinuation of therapy as naproxen may cause photosensitivity. '
          'Discontinue use if rash develops. Not for ophthalmic use. '
          'Use with caution in patients with a history of gastrointestinal disorders, '
          'cardiovascular disease, hepatic impairment, or renal impairment.',
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildPregnancySection() {
    return const Text(
      'Pregnancy Category C: Avoid use during pregnancy, especially during the third trimester, '
          'as NSAIDs may cause premature closure of the ductus arteriosus. '
          'Naproxen is excreted in breast milk in small amounts. Use with caution in nursing mothers.',
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildTherapeuticClassSection() {
    return const Text(
      'Non-Steroidal Anti-Inflammatory Drug (NSAID), Topical Analgesic',
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildModeOfActionSection() {
    return const Text(
      'Naproxen is a nonsteroidal anti-inflammatory drug (NSAID) that exhibits anti-inflammatory, '
          'analgesic, and antipyretic properties. Its mechanism of action is through inhibition of '
          'prostaglandin synthesis via cyclooxygenase (COX-1 and COX-2) inhibition. When applied topically, '
          'it provides localized relief with minimal systemic absorption.',
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildInteractionSection() {
    return const Text(
      'Although systemic absorption is low with topical application, potential interactions may occur '
          'with other NSAIDs, anticoagulants (e.g., warfarin), antiplatelet agents, ACE inhibitors, '
          'diuretics, lithium, and methotrexate. Consult a healthcare professional before using with '
          'other medications.',
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildPackSizePriceSection() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Pack Size')),
        DataColumn(label: Text('Form')),
        DataColumn(label: Text('Price (BDT)')),
      ],
      rows: const [
        DataRow(cells: [
          DataCell(Text('30g tube')),
          DataCell(Text('Gel')),
          DataCell(Text('80.00')),
        ]),
        DataRow(cells: [
          DataCell(Text('50g tube')),
          DataCell(Text('Gel')),
          DataCell(Text('120.00')),
        ]),
        DataRow(cells: [
          DataCell(Text('100g tube')),
          DataCell(Text('Gel')),
          DataCell(Text('200.00')),
        ]),
      ],
    );
  }
}