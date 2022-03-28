from flask import Flask
from flask_restful import Resource, Api, reqparse
import ast
app = Flask(__name__)
api = Api(app)

# Import ASCII Message Dependencies
import pyfiglet
import random

def getFonts():
    fonts = ["1943____","3-d","3x5","4x4_offr","5lineoblique","5x7","5x8","64f1____","6x10","6x9","a_zooloo","acrobatic","advenger","alligator","alligator2","alphabet","aquaplan","arrows","asc_____","ascii___","assalt_m","asslt__m","atc_____","atc_gran","avatar","b_m__200","banner","banner3","banner3-D","banner4","barbwire","basic","battle_s","battlesh","baz__bil","beer_pub","bell","big","bigchief","binary","block","brite","briteb","britebi","britei","broadway","bubble","bubble__","bubble_b","bulbhead","c1______","c2______","c_ascii_","c_consen","calgphy2","caligraphy","catwalk","caus_in_","char1___","char2___","char3___","char4___","charact1","charact2","charact3","charact4","charact5","charact6","characte","charset_","chartr","chartri","chunky","clb6x10","clb8x10","clb8x8","cli8x8","clr4x6","clr5x10","clr5x6","clr5x8","clr6x10","clr6x6","clr6x8","clr7x10","clr7x8","clr8x10","clr8x8","coil_cop","coinstak","colossal","com_sen_","computer","contessa","contrast","convoy__","cosmic","cosmike","cour","courb","courbi","couri","crawford","cricket","cursive","cyberlarge","cybermedium","cybersmall","d_dragon","dcs_bfmo","decimal","deep_str","defleppard","demo_1__","demo_2__","demo_m__","devilish","diamond","digital","doh","doom","dotmatrix","double","drpepper","druid___","dwhistled","e__fist_","ebbs_1__","ebbs_2__","eca_____","eftichess","eftifont","eftipiti","eftirobot","eftitalic","eftiwall","eftiwater","epic","etcrvs__","f15_____","faces_of","fair_mea","fairligh","fantasy_","fbr12___","fbr1____","fbr2____","fbr_stri","fbr_tilt","fender","finalass","fireing_","flyn_sh","fourtops","fp1_____","fp2_____","fraktur","funky_dr","future_1","future_2","future_3","future_4","future_5","future_6","future_7","future_8","fuzzy","gauntlet","ghost_bo","goofy","gothic","gothic__","graceful","gradient","graffiti","grand_pr","greek","green_be","hades___","heavy_me","helv","helvb","helvbi","helvi","heroboti","hex","high_noo","hills___","hollywood","home_pak","house_of","hypa_bal","hyper___","inc_raw_","invita","isometric1","isometric2","isometric3","isometric4","italic","italics_","ivrit","jazmine","jerusalem","joust___","katakana","kban","kgames_i","kik_star","krak_out","larry3d","lazy_jon","lcd","lean","letter_w","letters","letterw3","lexible_","linux","lockergnome","mad_nurs","madrid","magic_ma","marquee","master_o","maxfour","mayhem_d","mcg_____","mig_ally","mike","mini","mirror","mnemonic","modern__","morse","moscow","mshebrew210","nancyj","nancyj-fancy","nancyj-underlined","new_asci","nfi1____","nipples","notie_ca","npn_____","ntgreek","nvscript","o8","octal","odel_lak","ogre","ok_beer_","os2","outrun__","p_s_h_m_","p_skateb","pacos_pe","panther_","pawn_ins","pawp","peaks","pebbles","pepper","phonix__","platoon2","platoon_","pod_____","poison","puffy","pyramid","r2-d2___","rad_____","rad_phan","radical_","rainbow_","rally_s2","rally_sp","rampage_","rastan__","raw_recu","rci_____","rectangles","relief","relief2","rev","ripper!_","road_rai","rockbox_","rok_____","roman","roman___","rot13","rounded","rowancap","rozzo","runic","runyc","sans","sansb","sansbi","sansi","sblood","sbook","sbookb","sbookbi","sbooki","script","script__","serifcap","shadow","shimrod","short","skate_ro","skateord","skateroc","sketch_s","slant","slide","slscript","sm______","small","smisome1","smkeyboard","smscript","smshadow","smslant","smtengwar","space_op","spc_demo","speed","stacey","stampatello","standard","star_war","starwars","stealth_","stellar","stencil1","stencil2","stop","straight","street_s","subteran","super_te","t__of_ap","tanja","tav1____","taxi____","tec1____","tec_7000","tecrvs__","tengwar","term","thick","thin","threepoint","ti_pan__","ticks","ticksslant","tiles","times","timesofl","tinker-toy","tomahawk","tombstone","top_duck","trashman","trek","triad_st","ts1_____","tsalagi","tsm_____","tsn_base","tty","ttyb","tubular","twin_cob","twopoint","type_set","ucf_fan_","ugalympi","unarmed_","univers","usa_____","usa_pq__","usaflag","utopia","utopiab","utopiabi","utopiai","vortron_","war_of_w","wavy","weird","whimsy","xbrite","xbriteb","xbritebi","xbritei","xchartr","xchartri","xcour","xcourb","xcourbi","xcouri","xhelv","xhelvb","xhelvbi","xhelvi","xsans","xsansb","xsansbi","xsansi","xsbook","xsbookb","xsbookbi","xsbooki","xtimes","xtty","xttyb","yie-ar__","yie_ar_k","z-pilot_","zig_zag_","zone7___"]
    return fonts

class fonts(Resource):
    def get(self):
        data = getFonts()
        return [data], 200

class convert(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('message', required=True)
        parser.add_argument('font', required=False)
        args = parser.parse_args()
        if args.font is not None:
            font = args['font']
            if font == "random":
                fonts = getFonts()
                font = random.choice(fonts)
            else:
                font = args['font']
            returnMessage = pyfiglet.figlet_format(args['message'], font)
        else:
            returnMessage = pyfiglet.figlet_format(args['message'])
        return returnMessage, 200

api.add_resource(fonts, '/fonts')
api.add_resource(convert, '/convert')

if __name__ == '__main__':
    app.run()