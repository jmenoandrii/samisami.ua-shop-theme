{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{$homeSliderName = 'home-slider'}

{if $homeslider.slides}
  <div class="{$homeSliderName}__container">
    <div id="{$homeSliderName}" class="{$homeSliderName}">
      <div class="embla">
        <div class="embla__viewport">        
          <div class="embla__container">          
            {foreach from=$homeslider.slides item=slide name='homeslider'}
              <div class="embla__slide">
                <figure class="{$homeSliderName}__content">
                  <img src="{$slide.image_url}" alt="{$slide.legend|escape}" {if $slide@iteration == 1}loading="eager"{else}loading="lazy"{/if} {$slide.size|replace: '"':''}>
                  <div class="{$homeSliderName}__backdrop-img"></div>
                  {if $slide.title || $slide.description}
                    <figcaption class="{$homeSliderName}__caption">
                      <div class="{$homeSliderName}__caption-top">
                        <h2 class="{$homeSliderName}__title">{$slide.title}</h2>
                        <div class="{$homeSliderName}__description">{$slide.description nofilter}</div>
                      </div>
                      <div class="{$homeSliderName}__caption-bottom">
                        {if !empty($slide.url)}
                          <a class="{$homeSliderName}__link" href="{$slide.url}">{$slide.legend}</a>
                        {/if}
                      </div>
                    </figcaption>
                  {/if}
                </figure>
              </div>
            {/foreach}
          </div>
        </div>

        <div class="embla__buttons">
          <button class="embla__button embla__button--prev" type="button">
            <svg class="embla__button__svg" viewBox="0 0 532 532">
              <path
                fill="currentColor"
                d="M355.66 11.354c13.793-13.805 36.208-13.805 50.001 0 13.785 13.804 13.785 36.238 0 50.034L201.22 266l204.442 204.61c13.785 13.805 13.785 36.239 0 50.044-13.793 13.796-36.208 13.796-50.002 0a5994246.277 5994246.277 0 0 0-229.332-229.454 35.065 35.065 0 0 1-10.326-25.126c0-9.2 3.393-18.26 10.326-25.2C172.192 194.973 332.731 34.31 355.66 11.354Z"
              ></path>
            </svg>
          </button>
          <button class="embla__button embla__button--next" type="button">
            <svg class="embla__button__svg" viewBox="0 0 532 532">
              <path
                fill="currentColor"
                d="M176.34 520.646c-13.793 13.805-36.208 13.805-50.001 0-13.785-13.804-13.785-36.238 0-50.034L330.78 266 126.34 61.391c-13.785-13.805-13.785-36.239 0-50.044 13.793-13.796 36.208-13.796 50.002 0 22.928 22.947 206.395 206.507 229.332 229.454a35.065 35.065 0 0 1 10.326 25.126c0 9.2-3.393 18.26-10.326 25.2-45.865 45.901-206.404 206.564-229.332 229.52Z"
              ></path>
            </svg>
          </button>
        </div>

        <div class="{$homeSliderName}__hiders">
          <div class="{$homeSliderName}__hider {$homeSliderName}__hider-left">
          </div>
          <div class="{$homeSliderName}__hider {$homeSliderName}__hider-right">
          </div>
        </div>
      </div>
    </div>
  </div>
{/if}
