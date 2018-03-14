<?php

namespace lunar;

use think\Exception;

class Lunar
{
    //最小年份
    protected static $minYear = 1891;
    //最大年份
    protected static $maxYear = 2100;
    //农历数字
    protected static $cnNumbers = ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二'];
    //1891  至 2100 数据   0:闰月几月  1:月  2:天
    protected static $lunarInfo = [
        [0, 2, 9, 21936], [6, 1, 30, 9656], [0, 2, 17, 9584], [0, 2, 6, 21168], [5, 1, 26, 43344], [0, 2, 13, 59728],
        [0, 2, 2, 27296], [3, 1, 22, 44368], [0, 2, 10, 43856], [8, 1, 30, 19304], [0, 2, 19, 19168], [0, 2, 8, 42352],
        [5, 1, 29, 21096], [0, 2, 16, 53856], [0, 2, 4, 55632], [4, 1, 25, 27304], [0, 2, 13, 22176], [0, 2, 2, 39632],
        [2, 1, 22, 19176], [0, 2, 10, 19168], [6, 1, 30, 42200], [0, 2, 18, 42192], [0, 2, 6, 53840], [5, 1, 26, 54568],
        [0, 2, 14, 46400], [0, 2, 3, 54944], [2, 1, 23, 38608], [0, 2, 11, 38320], [7, 2, 1, 18872], [0, 2, 20, 18800],
        [0, 2, 8, 42160], [5, 1, 28, 45656], [0, 2, 16, 27216], [0, 2, 5, 27968], [4, 1, 24, 44456], [0, 2, 13, 11104],
        [0, 2, 2, 38256], [2, 1, 23, 18808], [0, 2, 10, 18800], [6, 1, 30, 25776], [0, 2, 17, 54432], [0, 2, 6, 59984],
        [5, 1, 26, 27976], [0, 2, 14, 23248], [0, 2, 4, 11104], [3, 1, 24, 37744], [0, 2, 11, 37600], [7, 1, 31, 51560],
        [0, 2, 19, 51536], [0, 2, 8, 54432], [6, 1, 27, 55888], [0, 2, 15, 46416], [0, 2, 5, 22176], [4, 1, 25, 43736],
        [0, 2, 13, 9680], [0, 2, 2, 37584], [2, 1, 22, 51544], [0, 2, 10, 43344], [7, 1, 29, 46248], [0, 2, 17, 27808],
        [0, 2, 6, 46416], [5, 1, 27, 21928], [0, 2, 14, 19872], [0, 2, 3, 42416], [3, 1, 24, 21176], [0, 2, 12, 21168],
        [8, 1, 31, 43344], [0, 2, 18, 59728], [0, 2, 8, 27296], [6, 1, 28, 44368], [0, 2, 15, 43856], [0, 2, 5, 19296],
        [4, 1, 25, 42352], [0, 2, 13, 42352], [0, 2, 2, 21088], [3, 1, 21, 59696], [0, 2, 9, 55632], [7, 1, 30, 23208],
        [0, 2, 17, 22176], [0, 2, 6, 38608], [5, 1, 27, 19176], [0, 2, 15, 19152], [0, 2, 3, 42192], [4, 1, 23, 53864],
        [0, 2, 11, 53840], [8, 1, 31, 54568], [0, 2, 18, 46400], [0, 2, 7, 46752], [6, 1, 28, 38608], [0, 2, 16, 38320],
        [0, 2, 5, 18864], [4, 1, 25, 42168], [0, 2, 13, 42160], [10, 2, 2, 45656], [0, 2, 20, 27216], [0, 2, 9, 27968],
        [6, 1, 29, 44448], [0, 2, 17, 43872], [0, 2, 6, 38256], [5, 1, 27, 18808], [0, 2, 15, 18800], [0, 2, 4, 25776],
        [3, 1, 23, 27216], [0, 2, 10, 59984], [8, 1, 31, 27432], [0, 2, 19, 23232], [0, 2, 7, 43872], [5, 1, 28, 37736],
        [0, 2, 16, 37600], [0, 2, 5, 51552], [4, 1, 24, 54440], [0, 2, 12, 54432], [0, 2, 1, 55888], [2, 1, 22, 23208],
        [0, 2, 9, 22176], [7, 1, 29, 43736], [0, 2, 18, 9680], [0, 2, 7, 37584], [5, 1, 26, 51544], [0, 2, 14, 43344],
        [0, 2, 3, 46240], [4, 1, 23, 46416], [0, 2, 10, 44368], [9, 1, 31, 21928], [0, 2, 19, 19360], [0, 2, 8, 42416],
        [6, 1, 28, 21176], [0, 2, 16, 21168], [0, 2, 5, 43312], [4, 1, 25, 29864], [0, 2, 12, 27296], [0, 2, 1, 44368],
        [2, 1, 22, 19880], [0, 2, 10, 19296], [6, 1, 29, 42352], [0, 2, 17, 42208], [0, 2, 6, 53856], [5, 1, 26, 59696],
        [0, 2, 13, 54576], [0, 2, 3, 23200], [3, 1, 23, 27472], [0, 2, 11, 38608], [11, 1, 31, 19176], [0, 2, 19, 19152],
        [0, 2, 8, 42192], [6, 1, 28, 53848], [0, 2, 15, 53840], [0, 2, 4, 54560], [5, 1, 24, 55968], [0, 2, 12, 46496],
        [0, 2, 1, 22224], [2, 1, 22, 19160], [0, 2, 10, 18864], [7, 1, 30, 42168], [0, 2, 17, 42160], [0, 2, 6, 43600],
        [5, 1, 26, 46376], [0, 2, 14, 27936], [0, 2, 2, 44448], [3, 1, 23, 21936], [0, 2, 11, 37744], [8, 2, 1, 18808],
        [0, 2, 19, 18800], [0, 2, 8, 25776], [6, 1, 28, 27216], [0, 2, 15, 59984], [0, 2, 4, 27424], [4, 1, 24, 43872],
        [0, 2, 12, 43744], [0, 2, 2, 37600], [3, 1, 21, 51568], [0, 2, 9, 51552], [7, 1, 29, 54440], [0, 2, 17, 54432],
        [0, 2, 5, 55888], [5, 1, 26, 23208], [0, 2, 14, 22176], [0, 2, 3, 42704], [4, 1, 23, 21224], [0, 2, 11, 21200],
        [8, 1, 31, 43352], [0, 2, 19, 43344], [0, 2, 7, 46240], [6, 1, 27, 46416], [0, 2, 15, 44368], [0, 2, 5, 21920],
        [4, 1, 24, 42448], [0, 2, 12, 42416], [0, 2, 2, 21168], [3, 1, 22, 43320], [0, 2, 9, 26928], [7, 1, 29, 29336],
        [0, 2, 17, 27296], [0, 2, 6, 44368], [5, 1, 26, 19880], [0, 2, 14, 19296], [0, 2, 3, 42352], [4, 1, 24, 21104],
        [0, 2, 10, 53856], [8, 1, 30, 59696], [0, 2, 18, 54560], [0, 2, 7, 55968], [6, 1, 27, 27472], [0, 2, 15, 22224],
        [0, 2, 5, 19168], [4, 1, 25, 42216], [0, 2, 12, 42192], [0, 2, 1, 53584], [2, 1, 21, 55592], [0, 2, 9, 54560]
    ];
    //天干
    public $tianGan = ['庚', '辛', '壬', '癸', '甲', '乙', '丙', '丁', '戊', '己'];
    //地支
    public $diZhi = ['申', '酉', '戌', '亥', '子', '丑', '寅', '卯', '辰', '巳', '午', '未'];
    //生肖
    public $zodiacsData = ['猴', '鸡', '狗', '猪', '鼠', '牛', '虎', '兔', '龙', '蛇', '马', '羊'];
    //24节气
    protected $jieQi = [
        '00' => "立春", '01' => "雨水", '02' => "惊蛰", '03' => "春分", '04' => "清明",
        '05' => "谷雨", '06' => "立夏", '07' => "小满", '08' => "芒种", '09' => "夏至",
        '10' => "小暑", '11' => "大暑", '12' => "立秋", '13' => "处暑", '14' => "白露",
        '15' => "秋分", '16' => "寒露", '17' => "霜降", '18' => "立冬", '19' => "小雪",
        '20' => "大雪", '21' => "冬至", '22' => '小寒', '23' => '大寒'
    ];
    //时辰
    protected $hourTime = [
        '23' => '子', '00' => '子', '01' => '丑', '02' => '丑', '03' => '寅', '04' => '寅',
        '05' => '卯', '06' => '卯', '07' => '辰', '08' => '辰', '09' => '巳', '10' => '巳',
        '11' => '午', '12' => '午', '13' => '未', '14' => '未', '15' => '申', '16' => '申',
        '17' => '酉', '18' => '酉', '19' => '戌', '20' => '戌', '21' => '亥', '22' => '亥'
    ];
    //时间对象(阳历)
    public $dateTime = null;

    public function __construct($year, $month = 0, $date = 0)
    {
        $this->dateTime = $this->getDateTime($year, $month, $date);
    }

    /**
     * 获取Lunar对象
     * @param int|string $year 年份、时间、时间戳
     * @param int $month 月
     * @param int $date 日
     * @return $this
     */
    public static function date($year, $month = 0, $date = 0)
    {
        static $object = [];
        $key = md5(json_encode([$year, $month, $date]));
        if (!isset($object[$key])) {
            $object[$key] = new static($year, $month, $date);
        }
        return $object[$key];
    }

    /**
     * 获取年、月、日、时的天干地支
     * @return array y:年 m:月 d:日 h:时    0:天干 1:地支
     */
    public function getLunarTganDzhi()
    {
        return [
            'y' => $this->getLunarGanzhiYear(),
            'm' => $this->getLunarGanzhiMonth(),
            'd' => $this->getLunarGanzhiDay(),
            'h' => $this->getLunarGanzhiHour(),
        ];
    }

    /**
     * 获取年天干地支
     * @return array 0:天干 1:地支
     */
    public function getLunarGanzhiYear()
    {
        $year = $this->getLunarYear();
        $lunarYear = (string)$year;
        return [$this->tianGan[$lunarYear{3}], $this->diZhi[$year % 12]];
    }

    /**
     * 获取月天干地支
     * @return array 0:天干 1:地支
     */
    public function getLunarGanzhiMonth()
    {
        //节气数据
        $result = $this->getJieQi();
        $year = $this->getLunarYear();
        $nT = $this->getLunarGanzhiYear()[0];
        //如果$m == 腊月  而且 $result['current'][0] == 00  的话那么年份减去1
        $num = array_keys($this->jieQi, $result['current'][0]);
        if ($num[0] == '00' && $this->getLunarYearMonth()[0] == '腊月') {
            $tianGanOffset = array_keys($this->tianGan, $nT);
            $tianGan = $this->tianGan[($tianGanOffset[0] + 1) % 10];
        } elseif ($result['next'][0] == '立春' && $year == $this->dateTime->format('Y')) {
            $tianGanOffset = array_keys($this->tianGan, $nT);
            $tianGan = $this->tianGan[($tianGanOffset[0] - 1) % 10];
        } else {
            $tianGan = $nT;
        }
        $jiNianMonthT = '';
        $jiNianMonthD = '';
        $offset = $num[0] / 2 + 4;
        if ($tianGan == '甲' || $tianGan == '己') {
            $jiNianMonthT = $this->tianGan[(2 + $offset) % 10];
            $jiNianMonthD = $this->diZhi[(2 + $offset) % 12];
        } elseif ($tianGan == '乙' || $tianGan == '庚') {
            $jiNianMonthT = $this->tianGan[(4 + $offset) % 10];
            $jiNianMonthD = $this->diZhi[(2 + $offset) % 12];
        } elseif ($tianGan == '丙' || $tianGan == '辛') {
            $jiNianMonthT = $this->tianGan[(6 + $offset) % 10];
            $jiNianMonthD = $this->diZhi[(2 + $offset) % 12];
        } elseif ($tianGan == '丁' || $tianGan == '壬') {
            $jiNianMonthT = $this->tianGan[(8 + $offset) % 10];
            $jiNianMonthD = $this->diZhi[(2 + $offset) % 12];
        } elseif ($tianGan == '戊' || $tianGan == '癸') {
            $jiNianMonthT = $this->tianGan[$offset % 10];
            $jiNianMonthD = $this->diZhi[(2 + $offset) % 12];
        }
        return [$jiNianMonthT, $jiNianMonthD];
    }

    /**
     * 获取日天干地支
     * @return array 0:天干 1:地支
     */
    public function getLunarGanzhiDay()
    {
        $dayCyclical = $this->dateTime->getTimestamp() / 86400 + 29219 + 18;
        //如果时 大于19时  就不四舍五入
        if ((int)$this->dateTime->format('H') < 15) {
            $dayCyclical = round($dayCyclical);
        }
        $dayCyclical = abs($dayCyclical);
        return [$this->tianGan[($dayCyclical + 4) % 10], $this->diZhi[($dayCyclical + 4) % 12]];
    }

    /**
     * 获取时天干地支
     * @return array 0:天干 1:地支
     */
    public function getLunarGanzhiHour()
    {
        $jiNianDayT = $this->getLunarGanzhiDay()[0];
        $jiNianHourD = $this->hourTime[$this->dateTime->format('H')];
        $of = [];
        if (in_array($jiNianDayT, ['甲', '己'])) {
            $of = [
                '子' => '甲', '丑' => '乙', '寅' => '丙', '卯' => '丁', '辰' => '戊', '巳' => '己',
                '午' => '庚', '未' => '辛', '申' => '壬', '酉' => '癸', '戌' => '甲', '亥' => '乙'
            ];
        } else if (in_array($jiNianDayT, ['乙', '庚'])) {
            $of = [
                '子' => '丙', '丑' => '丁', '寅' => '戊', '卯' => '己', '辰' => '庚', '巳' => '辛',
                '午' => '壬', '未' => '癸', '申' => '甲', '酉' => '乙', '戌' => '丙', '亥' => '丁'
            ];
        } else if (in_array($jiNianDayT, ['丙', '辛'])) {
            $of = [
                '子' => '戊', '丑' => '己', '寅' => '庚', '卯' => '辛', '辰' => '壬', '巳' => '癸',
                '午' => '甲', '未' => '乙', '申' => '丙', '酉' => '丁', '戌' => '戊', '亥' => '己'
            ];
        } else if (in_array($jiNianDayT, ['丁', '壬'])) {
            $of = [
                '子' => '庚', '丑' => '辛', '寅' => '壬', '卯' => '癸', '辰' => '甲', '巳' => '乙',
                '午' => '丙', '未' => '丁', '申' => '戊', '酉' => '己', '戌' => '庚', '亥' => '辛'
            ];
        } else if (in_array($jiNianDayT, ['戊', '癸'])) {
            $of = [
                '子' => '壬', '丑' => '癸', '寅' => '甲', '卯' => '乙', '辰' => '丙', '巳' => '丁',
                '午' => '戊', '未' => '己', '申' => '庚', '酉' => '辛', '戌' => '壬', '亥' => '癸'
            ];
        }
        return [$of[$jiNianHourD], $jiNianHourD];
    }

    /**
     * 获取节气
     * @return array current当前节气,next下一个节气
     */
    public function getJieQi()
    {
        $month = [
            1 => '22', 2 => '00', 3 => '02', 4 => '04', 5 => '06', 6 => '08',
            7 => '10', 8 => '12', 9 => '14', 10 => '16', 11 => '18', 12 => '20',
        ];
        //获取节气数据
        $getJieQiData = function ($year, $num) {
            $fp = fopen(__DIR__ . '/data/' . $num . '.dat', 'r');
            $content = fread($fp, filesize(__DIR__ . '/data/' . $num . '.dat'));
            $arr = explode("\n", $content);
            fclose($fp);
            return [$this->jieQi[$num], trim($arr[$year])];
        };
        $year = $this->dateTime->format('Y');
        $m = $this->dateTime->format('m');
        //获取当前大致那个时令
        $theMonthJieQiData = $getJieQiData($year, $month[(int)$m]);
        //如果大致时令时间大于当前时间，那么本身时令就需要获取上一个月时令
        if (strtotime($theMonthJieQiData[1]) > $this->dateTime->getTimestamp()) {
            $data = [
                'current' => (int)$m == 1 ? $getJieQiData($year - 1, '20') : $getJieQiData($year, $month[(int)$m - 1]),//当前时令
                'next' => $theMonthJieQiData,//下一个时令
            ];
            //不是就是获取下一个月时令， 不可能出现，比下一个时令还大的时间
        } else {
            $data = [
                'current' => $theMonthJieQiData,
                'next' => (int)$m == 12 ? $getJieQiData((int)$year + 1, '22') : $getJieQiData($year, $month[(int)$m + 1]),
            ];
        }
        return $data;
    }

    /**
     * 根据距离正月初一的天数计算的农历日期
     * @return array 0:年 1:月 2:日 3:年天干地支 4:月天干地支 5:日天干地支 6:生肖 7:数字农历年月日
     */
    public function getLunarByBetween()
    {
        //获取现在是农历那年
        $year = $this->getLunarYear();
        $yearMonth = $this->getLunarYearMonth();
        $yearDay = $this->getLunarYearDay();
        $lunarArray = [
            self::toYear($year),
            $yearMonth[0],
            $yearDay[0],
            $this->getLunarGanzhiYear(),
            $this->getLunarGanzhiMonth(),
            $this->getLunarGanzhiDay(),
            $this->getZodiac(),
            [$year, $yearMonth[1], $yearDay[1]]
        ];
        return $lunarArray;
    }

    /**
     * 判断是否闰年
     * @return boolean
     */
    public function isLeapYear()
    {
        $year = $this->dateTime->format('Y');
        return ($year % 4 == 0 && $year % 100 != 0) || ($year % 400 == 0);
    }

    /**
     * 获取闰月
     * @param number $year 年份
     * @return mixed
     */
    public function getLeapMonth($year = null)
    {
        $year = $year ?: $this->dateTime->format('Y');
        $yearData = self::$lunarInfo[$year - self::$minYear];
        return $yearData[0];
    }

    /**
     * 获取现在是农历那年
     * 是根据阳历日期获得当前是农历那年
     * @return int
     */
    public function getLunarYear()
    {
        $between = $this->getDaysBetweenSolar();
        $year = (int)$this->dateTime->format('Y');
        $year = $between >= 0 ? $year : ($year - 1);
        return $year;
    }

    /**
     * 获取现在是农历那月
     * 是根据阳历日期获得当前是农历那月
     * @return array 中文,数字
     */
    public function getLunarYearMonth()
    {
        //距离农历正月初一还有差多少天
        $between = $this->getDaysBetweenSolar();
        if ($between == 0) {
            $m = ['正月', 1];
        } else {
            //农历年份
            $year = $this->getLunarYear();
            $t = 0;
            //获取农历每月最后一天是该农历总天数的第几天
            $yearMonth = self::getLunarYearMonths($year);
            //获取闰月
            $leapMonth = $this->getLeapMonth($year);
            $between = $between > 0 ? $between : (self::getLunarYearDays($year) + $between);
            for ($i = 0; $i < 13; $i++) {
                if ($between == $yearMonth[$i]) {
                    $t = $i + 2;
                    break;
                } else if ($between < $yearMonth[$i]) {
                    $t = $i + 1;
                    break;
                }
            }
            $isrun = '';
            if ($leapMonth != 0 && $t == $leapMonth + 1) {
                $isrun = '闰';
                $t2 = $t - 1;
            } else {
                $t2 = ($leapMonth != 0 && $leapMonth + 1 < $t ? ($t - 1) : $t);
            }
            $m = [$isrun . self::getCapitalNum($t2, true), $t2];
        }
        return $m;
    }

    /**
     * 获取现在是农历那天
     * 是根据阳历日期获得当前是农历那月
     * @return array 中文,数字
     */
    public function getLunarYearDay()
    {
        //距离农历正月初一还有差多少天
        $between = $this->getDaysBetweenSolar();
        if ($between == 0) {
            $d = ['初一', 1];
        } else {
            //农历年份
            $year = $this->getLunarYear();
            $e = 0;
            //获取农历每月最后一天是该农历总天数的第几天
            $yearMonth = self::getLunarYearMonths($year);
            $between = $between > 0 ? $between : (self::getLunarYearDays($year) + $between);
            for ($i = 0; $i < 13; $i++) {
                if ($between == $yearMonth[$i]) {
                    $e = 1;
                    break;
                } else if ($between < $yearMonth[$i]) {
                    $e = $between - (empty($yearMonth[$i - 1]) ? 0 : $yearMonth[$i - 1]) + 1;
                    break;
                }
            }
            $d = [self::getCapitalNum($e, false), $e];
        }
        return $d;
    }

    /**
     * 获取所属生肖
     * @return string 生肖
     */
    public function getZodiac()
    {
        //获取现在是农历那年
        $year = $this->getLunarYear();
        return $this->zodiacsData[$year % 12];
    }

    /**
     * 期距离本年的正月初一有多少天(感觉不准)
     * 用的是阳历年份，所以返回值如果是负数代表还差几天，正数，已经过了几天
     * @return int
     */
    protected function getDaysBetweenSolar()
    {
        $yearData = self::$lunarInfo[$this->dateTime->format('Y') - self::$minYear];
        $currenData = mktime(0, 0, 0, (int)$this->dateTime->format('m'), (int)$this->dateTime->format('d'), $this->dateTime->format('Y'));
        $nextData = mktime(0, 0, 0, $yearData[1], $yearData[2], $this->dateTime->format('Y'));
        return ceil(($currenData - $nextData) / 24 / 3600);
    }

    /**
     * 将输入内容转换成时间戳
     * @param int|string $year 支持时间戳(阳历)，字符串(阳历)，阳历-年份
     * @param int $month 阳历-月份
     * @param int $date 阳历-日期
     * @return \DateTime
     */
    protected function getDateTime($year, $month = 0, $date = 0)
    {
        $timezone = new \DateTimeZone('Asia/Shanghai');
        $datetime = new \DateTime();
        $datetime->setTimezone($timezone);

        if (is_string($year) && !is_numeric($year) && $year > 0 && $month == 0 && $date == 0) {
            //字符串形式
            $datetime->setTimestamp(strtotime($year));
        } else if (preg_match("/^(-|\d+)\d+/", $year) && $month == 0 && $date == 0) {
            //时间戳形式
            $datetime->setTimestamp($year);
        }

        if ($year && $month && $date) {
            $datetime->setDate($year, $month, $date);
        }
        $this->isValidDate($datetime);
        return $datetime;
    }

    /**
     * 检查时间是否正确
     * @param $datetime
     * @return bool
     */
    protected function isValidDate(\DateTime $datetime)
    {
        if ((int)$datetime->format('Y') < self::$minYear || (int)$datetime->format('Y') > self::$maxYear) {
            $dateString = $datetime->format('Y.n.j');
            throw new Exception("Error: expected date {$dateString}, expecting 1891.2.9 - 2100.2.9");
        }
        return true;
    }

    /**
     * 获取农历总天数
     * @param number $year 阳历年份
     * @return int 天数
     */
    public static function getLunarYearDays($year)
    {
        $monthArray = self::getLunarYearMonths($year);
        $len = count($monthArray);
        return ($monthArray[$len - 1] == 0 ? $monthArray[$len - 2] : $monthArray[$len - 1]);
    }

    /**
     * 获取农历每月天数的数组
     * @param number $year 年份
     * @return array
     */
    public static function getLunarMonths($year)
    {
        $yearData = self::$lunarInfo[$year - self::$minYear];
        $leapMonth = $yearData[0];
        //把十进制转换为二进制
        $bit = decbin($yearData[3]);
        $bitArray = [];
        for ($i = 0; $i < strlen($bit); $i++) {
            $bitArray[$i] = substr($bit, $i, 1);
        }
        for ($k = 0, $klen = 16 - count($bitArray); $k < $klen; $k++) {
            array_unshift($bitArray, '0');
        }
        $bitArray = array_slice($bitArray, 0, ($leapMonth == 0 ? 12 : 13));
        for ($i = 0; $i < count($bitArray); $i++) {
            $bitArray[$i] = $bitArray[$i] + 29;
        }
        return $bitArray;
    }

    /**
     * 获取农历每月最后一天是该农历总天数的第几天
     * @param number $year 农历年份
     * @return array
     */
    public static function getLunarYearMonths($year)
    {
        $monthData = self::getLunarMonths($year);
        $yearData = self::$lunarInfo[$year - self::$minYear];
        $len = ($yearData[0] == 0 ? 12 : 13);
        $result = [];
        for ($i = 0; $i < $len; $i++) {
            $temp = 0;
            for ($j = 0; $j <= $i; $j++) {
                $temp += $monthData[$j];
            }
            $result[] = $temp;
        }
        return $result;
    }

    /**
     * 将农历转换为阳历
     * @param number $year 农历-年
     * @param number $month 农历-月，闰月处理：例如如果当年闰五月，那么第二个五月就传六月，相当于阴历有13个月，只是有的时候第13个月的天数为0
     * @param number $date 农历-日
     * @return array
     */
    public static function convertLunarToSolar($year, $month, $date)
    {
        $yearData = self::$lunarInfo[$year - self::$minYear];
        $between = self::getDaysBetweenLunar($year, $month, $date);
        $res = mktime(0, 0, 0, $yearData[1], $yearData[2], $year);
        $res = date('Y-m-d', $res + $between * 24 * 60 * 60);
        $day = explode('-', $res);
        $year = $day[0];
        $month = $day[1];
        $day = $day[2];
        return [$year, $month, $day];
    }

    /**
     * 计算农历第一天到指定时间相隔多少天
     * @param number $year
     * @param number $month
     * @param number $date
     * @return number
     */
    public static function getDaysBetweenLunar($year, $month, $date)
    {
        //获取农历每月天数的数组
        $yearMonth = self::getLunarMonths($year);
        $res = 0;
        for ($i = 1; $i < $month; $i++) {
            $res += $yearMonth[$i - 1];
        }
        $res += $date - 1;
        return $res;
    }

    /**
     * 获取年份的大写叫法 eg. 二零一四
     * @param number $year 年份
     * @return string
     */
    public static function toYear($year)
    {
        $yearArr = str_split($year);
        return self::$cnNumbers[$yearArr[0]] . self::$cnNumbers[$yearArr[1]] . self::$cnNumbers[$yearArr[2]] . self::$cnNumbers[$yearArr[3]];
    }

    /**
     * 获取月份或日期的阴历叫法 eg. 腊月 | 初八
     * @param number $num 数字
     * @param boolean $isMonth 是否是月份的数字
     * @return string
     */
    public static function getCapitalNum($num, $isMonth = false)
    {
        $monthHash = ['', '正', '二', '三', '四', '五', '六', '七', '八', '九', '十', '冬', '腊'];
        $dateHash = ['', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十'];
        if ($isMonth) {
            return $monthHash[$num] . '月';
        }
        $str = '';
        if ($num <= 10) {
            $str = '初' . $dateHash[$num];
        } else if ($num > 10 && $num < 20) {
            $str = '十' . $dateHash[$num - 10];
        } else if ($num == 20) {
            $str = "二十";
        } else if ($num > 20 && $num < 30) {
            $str = "廿" . $dateHash[$num - 20];
        } else if ($num == 30) {
            $str = "三十";
        }
        return $str;
    }

}