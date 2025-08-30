-- Create medicine_product_type table with comprehensive columns
CREATE TABLE IF NOT EXISTS medicine_product_type (
    id SERIAL PRIMARY KEY,
    sl_number INTEGER NOT NULL,
    manufacturer_name VARCHAR(255) NOT NULL,
    brand_name VARCHAR(255) NOT NULL,
    generic_name_strength VARCHAR(255) NOT NULL,
    dosage_form VARCHAR(100) NOT NULL,
    use_for VARCHAR(100) NOT NULL,
    dar_number VARCHAR(50) NOT NULL,
    indication TEXT,
    price DECIMAL(10,2),
    adult_dose TEXT,
    child_dose TEXT,
    renal_dose TEXT,
    administration TEXT,
    side_effects TEXT,
    precautions_warnings TEXT,
    pregnancy_lactation TEXT,
    mode_of_action TEXT,
    interaction TEXT,
    pack_size VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_medicine_brand_name ON medicine_product_type(brand_name);
CREATE INDEX IF NOT EXISTS idx_medicine_manufacturer ON medicine_product_type(manufacturer_name);
CREATE INDEX IF NOT EXISTS idx_medicine_generic_name ON medicine_product_type(generic_name_strength);
CREATE INDEX IF NOT EXISTS idx_medicine_dar_number ON medicine_product_type(dar_number);

-- Insert sample data based on the provided table structure
INSERT INTO medicine_product_type (
    sl_number, manufacturer_name, brand_name, generic_name_strength, 
    dosage_form, use_for, dar_number, indication, price, adult_dose, 
    child_dose, renal_dose, administration, side_effects, precautions_warnings, 
    pregnancy_lactation, mode_of_action, interaction, pack_size
) VALUES 
(
    1, 'ACI HealthCare Limited', 'Nimocon 500', 'Azithromycin 500 mg',
    'Tablet', 'Human', '394-0001-023',
    'Bacterial infections including respiratory tract infections, skin and soft tissue infections, sexually transmitted diseases',
    25.50,
    '500mg once daily for 3-5 days',
    '10mg/kg once daily for 3-5 days (max 500mg)',
    'No dose adjustment needed for mild to moderate renal impairment',
    'Take with or without food. Take at least 2 hours before or after antacids',
    'Nausea, vomiting, diarrhea, abdominal pain, headache, dizziness',
    'Use with caution in patients with liver disease. May cause QT prolongation',
    'Category B: Generally safe during pregnancy. Excreted in breast milk',
    'Bacteriostatic antibiotic that inhibits protein synthesis by binding to 50S ribosomal subunit',
    'May interact with warfarin, digoxin, theophylline. Avoid with ergot alkaloids',
    '10 tablets per strip'
),
(
    2, 'ACI HealthCare Limited', 'Adbon', 'Calcium + Vitamin D3 500 mg + 200 IU',
    'Tablet', 'Human', '394-0002-062',
    'Calcium and vitamin D deficiency, osteoporosis prevention and treatment',
    15.75,
    '1-2 tablets twice daily with meals',
    '1 tablet daily for children above 12 years',
    'No dose adjustment needed',
    'Take with food for better absorption',
    'Constipation, bloating, gas, nausea',
    'Use with caution in patients with kidney stones or hypercalcemia',
    'Category C: Use only if clearly needed during pregnancy',
    'Calcium provides structural support for bones and teeth. Vitamin D3 enhances calcium absorption',
    'May decrease absorption of tetracyclines and fluoroquinolones',
    '30 tablets per bottle'
),
(
    3, 'ACI HealthCare Limited', 'Opental 50', 'Tramadol 50 mg',
    'Tablet', 'Human', '394-0003-065',
    'Moderate to severe pain management',
    8.25,
    '50-100mg every 4-6 hours as needed (max 400mg/day)',
    'Not recommended for children under 12 years',
    'Reduce dose by 50% in severe renal impairment',
    'Take with or without food',
    'Nausea, vomiting, constipation, dizziness, drowsiness, headache',
    'Risk of addiction and dependence. Use with caution in elderly patients',
    'Category C: Use only if clearly needed during pregnancy',
    'Opioid analgesic that binds to mu-opioid receptors and inhibits norepinephrine reuptake',
    'May interact with MAO inhibitors, SSRIs, alcohol. Avoid with other CNS depressants',
    '20 tablets per strip'
),
(
    4, 'ACI HealthCare Limited', 'Acidex 20', 'Omeprazole 20 mg',
    'Capsule', 'Human', '394-0004-067',
    'Gastroesophageal reflux disease (GERD), peptic ulcer disease, Zollinger-Ellison syndrome',
    12.00,
    '20mg once daily before breakfast',
    'Not recommended for children under 1 year',
    'No dose adjustment needed for mild to moderate renal impairment',
    'Take 30-60 minutes before meals',
    'Headache, diarrhea, nausea, abdominal pain, flatulence',
    'May increase risk of bone fractures with long-term use. Monitor for vitamin B12 deficiency',
    'Category C: Use only if clearly needed during pregnancy',
    'Proton pump inhibitor that irreversibly blocks H+/K+-ATPase enzyme in gastric parietal cells',
    'May interact with clopidogrel, warfarin, phenytoin. Avoid with atazanavir',
    '14 capsules per strip'
),
(
    5, 'Square Pharmaceuticals Ltd', 'Napa 500', 'Paracetamol 500 mg',
    'Tablet', 'Human', '394-0005-089',
    'Fever, mild to moderate pain relief',
    2.50,
    '500-1000mg every 4-6 hours (max 4000mg/day)',
    '10-15mg/kg every 4-6 hours (max 75mg/kg/day)',
    'No dose adjustment needed',
    'Take with or without food',
    'Rare: skin rash, blood disorders, liver damage with overdose',
    'Do not exceed recommended dose. Use with caution in liver disease',
    'Category B: Generally safe during pregnancy and breastfeeding',
    'Inhibits cyclooxygenase enzymes, reducing prostaglandin synthesis in CNS',
    'May interact with warfarin. Avoid with alcohol',
    '20 tablets per strip'
),
(
    6, 'Beximco Pharmaceuticals Ltd', 'Napa Extra', 'Paracetamol 500 mg + Caffeine 65 mg',
    'Tablet', 'Human', '394-0006-092',
    'Headache, migraine, tension headache, fever with pain',
    3.75,
    '1-2 tablets every 4-6 hours (max 8 tablets/day)',
    'Not recommended for children under 12 years',
    'No dose adjustment needed',
    'Take with or without food',
    'Nausea, nervousness, insomnia, rapid heartbeat',
    'Avoid in patients with heart conditions. Limit caffeine intake',
    'Category B: Generally safe during pregnancy',
    'Paracetamol provides pain relief and fever reduction. Caffeine enhances analgesic effect',
    'May interact with warfarin. Caffeine may interact with other stimulants',
    '20 tablets per strip'
),
(
    7, 'Incepta Pharmaceuticals Ltd', 'Ace 100', 'Aceclofenac 100 mg',
    'Tablet', 'Human', '394-0007-105',
    'Rheumatoid arthritis, osteoarthritis, ankylosing spondylitis, pain and inflammation',
    18.50,
    '100mg twice daily with meals',
    'Not recommended for children under 12 years',
    'Reduce dose by 50% in severe renal impairment',
    'Take with food to reduce gastric irritation',
    'Nausea, vomiting, diarrhea, abdominal pain, headache, dizziness',
    'Use with caution in patients with heart disease, high blood pressure, kidney problems',
    'Category C: Avoid during third trimester of pregnancy',
    'Non-steroidal anti-inflammatory drug (NSAID) that inhibits cyclooxygenase enzymes',
    'May interact with warfarin, lithium, methotrexate. Avoid with other NSAIDs',
    '20 tablets per strip'
);

-- Create a trigger to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_medicine_product_type_updated_at 
    BEFORE UPDATE ON medicine_product_type 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();
