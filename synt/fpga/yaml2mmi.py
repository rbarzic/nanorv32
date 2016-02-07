import yaml

header="""
<?xml version="1.0" encoding="UTF-8"?>
<MemInfo Version="1" Minor="0">
    <Processor Endianness="Little" InstPath="design/cortex">
        <AddressSpace
            Name="design_1_i_microblaze_0.design_1_i_microblaze_0_local_memory_dlmb_bram_if_cntlr" Begin="0" End="8191">

            <BusBlock>
"""


footer="""
   </BusBlock>
        </AddressSpace>
    </Processor>
    <Config>
        <Option Name="Part" Val="xc7a35tcsg324-1"/>
    </Config>
</MemInfo>

"""

bitlane="""
<BitLane MemType="{type}" Placement="{placement}">
  <DataWidth MSB="{msb}" LSB="{lsb}"/>
  <AddressRange Begin="0" End="{end_address}"/>
  <Parity ON="false" NumBits="0"/>
</BitLane>
"""

remap = [3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]

bram = open("bram.yaml", "r")
doc = yaml.load(bram)

bit_pos   = 0
bit_width = 2
output = header
# for bram  in doc['bram']:
for i in range(len(doc['bram'])):

    bram = doc['bram'][remap[i]]
    data = dict()
    # print bram

    data['lsb'] = bit_pos
    data['msb'] = bit_pos + bit_width - 1
    data['end_address'] = 16383
    data['type'] = 'RAMB36E1'
    data['placement'] = bram['SITE'].split('_')[1] # remove RAMB36_ in front of the position string
    bit_pos += bit_width
    output += bitlane.format(**data)

output += footer
print output
