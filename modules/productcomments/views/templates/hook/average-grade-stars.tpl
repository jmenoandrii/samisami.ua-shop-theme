{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}


<div class="comments-note">
  {if isset($showOneStar) && $showOneStar}
    <div class="grade-star" data-grade="1">
      <div class="star-content star-full clearfix">
        <svg class="star-on" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 10 10" fill="none">
          <path d="M2.25665 9.962C2.0154 10.094 1.74165 9.86267 1.7904 9.56735L2.30915 6.41412L0.107283 4.17686C-0.0983413 3.96753 0.00853337 3.58488 0.284158 3.54355L3.3454 3.07956L4.7104 0.194994C4.83352 -0.0649978 5.16664 -0.0649978 5.28977 0.194994L6.65477 3.07956L9.71601 3.54355C9.99163 3.58488 10.0985 3.96753 9.89226 4.17686L7.69101 6.41412L8.20976 9.56735C8.25851 9.86267 7.98476 10.094 7.74351 9.962L4.99914 8.45805L2.25665 9.962Z"/>
        </svg>
      </div>
    </div>
  {else}
    {assign var=intGrade value=$grade|intval}
    <div class="grade-stars" data-grade="{$grade}">
      {for $i=1 to 5}
        <div class="star-content clearfix">
          <svg class="{if $i <= $intGrade || $intGrade == 0}star-on{else}star-off{/if}" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 10 10" fill="none">
            <path d="M2.25665 9.962C2.0154 10.094 1.74165 9.86267 1.7904 9.56735L2.30915 6.41412L0.107283 4.17686C-0.0983413 3.96753 0.00853337 3.58488 0.284158 3.54355L3.3454 3.07956L4.7104 0.194994C4.83352 -0.0649978 5.16664 -0.0649978 5.28977 0.194994L6.65477 3.07956L9.71601 3.54355C9.99163 3.58488 10.0985 3.96753 9.89226 4.17686L7.69101 6.41412L8.20976 9.56735C8.25851 9.86267 7.98476 10.094 7.74351 9.962L4.99914 8.45805L2.25665 9.962Z"/>
          </svg>
        </div>
      {/for}
    </div>
  {/if}
  {if isset($showNbComments) && $showNbComments}
    <div class="comments-number">({$nb_comments})</div>
  {elseif isset($showGradeAverage) && $showGradeAverage}
    <div class="average-grade">{if $grade}{$grade|string_format:"%.1f"}{else}5.0{/if}</div>
  {/if}
</div>
