{$homeBanners = 'home-banners'}

<section class="{$homeBanners}__container">
    <div class="container sami-container">
        {foreach from=$banners item=banner}
            <div class="{$homeBanners}__item {$homeBanners}__item-{$banner.display_mode}
                        align-x-{$banner.text_position_x} 
                        align-y-{$banner.text_position_y}"
                 style="{if $banner.background_type == 'color'}
                            background-color: {$banner.background_color};
                        {elseif $banner.background_image}
                            background-image: url('{$module_dir}views/img/{$banner.background_image}');
                        {/if}">
                
                <div class="{$homeBanners}__content">
                    {if $banner.title}
                        <h2 class="{$homeBanners}__title">{$banner.title|escape:'html':'UTF-8'}</h2>
                    {/if}
                    
                    {if $banner.text}
                        <div class="{$homeBanners}__text">
                            {$banner.text|nl2br nofilter}
                        </div>
                    {/if}
                    
                    {if $banner.button_enabled && $banner.button_text && $banner.button_link}
                        <div class="{$homeBanners}__button-wrapper">
                            <a href="{$banner.button_link|escape:'html':'UTF-8'}" 
                                class="{$homeBanners}__button">
                                {$banner.button_text|escape:'html':'UTF-8'}
                            </a>
                        </div>
                    {/if}
                </div>
            </div>
        {/foreach}
    </div>
</section>