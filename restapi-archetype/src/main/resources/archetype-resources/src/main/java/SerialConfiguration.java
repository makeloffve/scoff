package ${package};

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.cbor.MappingJackson2CborHttpMessageConverter;
import org.springframework.http.converter.json.GsonHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.lang.reflect.Modifier;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

@Configuration
public class SerialConfiguration implements WebMvcConfigurer {

    private static final String DATE_FORMATTER = "yyyy-mm-dd hh:MM:ss";
    private static final String CHARSET_UTF8 = "UTF-8";

    @Bean
    public Gson gson() {
        return new GsonBuilder()
                .serializeNulls()
                .setDateFormat(DATE_FORMATTER)
                .excludeFieldsWithModifiers(Modifier.STATIC, Modifier.TRANSIENT, Modifier.VOLATILE)
                .create();
    }

    @Override
    public void extendMessageConverters(List<HttpMessageConverter<?>> converters) {
        GsonHttpMessageConverter converter = new GsonHttpMessageConverter(gson());
        converter.setDefaultCharset(Charset.forName(CHARSET_UTF8));
        ArrayList<MediaType> supportMediaTypes = new ArrayList<>();
        supportMediaTypes.add(MediaType.APPLICATION_JSON_UTF8);
        converter.setSupportedMediaTypes(supportMediaTypes);
        converters.add(converter);
        converters.removeIf(httpMessageConverter -> httpMessageConverter instanceof MappingJackson2HttpMessageConverter);
        converters.removeIf(httpMessageConverter -> httpMessageConverter instanceof MappingJackson2CborHttpMessageConverter);
    }
}