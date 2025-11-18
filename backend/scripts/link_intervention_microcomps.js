// This script will be used to generate SQL for linking microcompetencies to interventions
// Based on the Excel data analysis

const interventions = {
  'Storytelling Presentation': {
    id: '10592226-5c71-4347-98d1-bef3f268c3e6',
    microcomps: ['A1', 'A2', 'A3', 'A4', 'C1', 'C2', 'C3', 'C5', 'D3', 'D4', 'D5', 'E1', 'E3', 'P1', 'P2', 'P3', 'P4', 'T1']
  },
  'Book Review Presentation': {
    id: 'e3333bcf-0063-4695-953d-c265841e70ef',
    microcomps: ['A1', 'A2', 'A3', 'A4', 'C1', 'C2', 'C3', 'C5', 'D3', 'D4', 'D5', 'E1', 'E3', 'P1', 'P2', 'P3', 'P4', 'T1']
  },
  'Interpersonal Role Play': {
    id: '2afd5445-be87-42ce-81fb-2d336589e1c1',
    microcomps: ['D3', 'D4', 'D5', 'T4', 'T5']
  },
  'Case Study Analysis': {
    id: '188785d1-0099-46d8-aee2-e68ef52677f5',
    microcomps: ['D3', 'D4', 'D5', 'P1', 'P2', 'P3', 'P4']
  },
  'Business Proposal Report': {
    id: '0d049f75-7f7a-47a6-bec2-4ca28aa65032',
    microcomps: ['A1', 'A2', 'A3', 'A4', 'C1', 'D3', 'D4', 'D5', 'E1', 'P1', 'P2', 'P3', 'P4']
  },
  'Email Writing': {
    id: '9ffaa769-b766-4f79-ad27-3856a93864d2',
    microcomps: ['C4', 'D3', 'D4', 'D5']
  },
  'Debating': {
    id: '662c0bb2-b01f-4cf0-a8e7-2ceaf0439e0d',
    microcomps: ['A1', 'A2', 'A3', 'A4', 'C1', 'C2', 'C3', 'C5', 'D3', 'D4', 'D5', 'L1', 'T1']
  }
};

const microcompMap = {
  'A1': '4476c3a6-58da-4c43-9b8a-b1da70172072',
  'A2': '31a4c844-6a46-4b57-a23d-91d9a5ff7382',
  'A3': '4d6b4184-d62e-427a-ba00-16ff3f4e4f10',
  'A4': '06947927-aab0-4d24-b5fe-b42c0b83050c',
  'C1': '7e8983cd-5a94-49cc-9b80-64358a9d48f9',
  'C2': '685d23ad-eadc-47ac-9f91-8f741ae4211f',
  'C3': '2e599a1f-e34d-436c-98f9-01f019cb29bd',
  'C4': '1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1',
  'C5': '44a43cc4-8d2e-4ce5-b437-2b76a205ea84',
  'D3': '0322c72d-2fbf-462d-9a59-76e1550b30d9',
  'D4': 'ec97e568-30d6-4e8f-acb3-b74d1b4b5436',
  'D5': '41ab0a41-f16e-4bd5-961e-5b070acd6410',
  'E1': '08314805-8508-4254-997b-a035415747d5',
  'E3': '76e855c0-ec81-4eae-a010-0e23b76426f1',
  'L1': '2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77',
  'P1': '88fad813-46ed-4601-a334-ae77df797be3',
  'P2': '9358b2c4-aebc-480a-9eff-6873c156da12',
  'P3': 'd5760d32-ce61-48fd-988e-9bd16cc52ca1',
  'P4': '7022a346-204b-472a-b46b-b801f07e8853',
  'T1': '6852ffde-5e9e-4faa-be78-93d194b1f8b7',
  'T4': '7453ffe7-e829-4f52-a16b-44efbc183640',
  'T5': 'fbd8f3d7-1bbe-4e3c-955f-c370b9f7f680'
};

let sql = '-- Link microcompetencies to interventions\n';
sql += 'INSERT INTO intervention_microcompetencies (intervention_id, microcompetency_id, weightage, max_score, is_active)\nVALUES\n';

const values = [];
Object.keys(interventions).forEach(intName => {
  const int = interventions[intName];
  int.microcomps.forEach(mcCode => {
    const mcId = microcompMap[mcCode];
    if (mcId) {
      values.push(`('${int.id}', '${mcId}', 1.0, 10.0, true)`);
    }
  });
});

sql += values.join(',\n') + ';\n';

console.log(sql);

